import 'dart:convert';

enum Origen {
  camaras,
  requerimientoTelefonico,
  patrullaje,
  operativos,
  redesSociales,
  botonPanico,
  otros,
}

enum ModalidadPatrullaje { integrado, municipal, otro }

enum TipoPatrullaje { motorizado, aPie, bicicleta, otro }

enum TipoVehiculo { auto, camionetaDobleCabina, motoLineal, otro }

enum Turno { manana, tarde, noche }

class GeneralidadesModel {
  int? id; // para SQLite autoincrement
  // Sereno
  String? serenoDni;
  String? serenoApellidos;
  String? serenoNombres;

  // Ubigeo
  // String ubigeo; // código ubigeo concatenado (ej: '080101') o null
  String? departamento;
  String? provincia;
  String? distrito;

  // Origen (puede seleccionar varios)
  List<Origen> origenes;

  // Modalidad patrullaje
  ModalidadPatrullaje? modalidadPatrullaje;

  // Información efectivo PNP
  String? infoPnpApellidos;
  String? infoPnpNombres;
  String? infoPnpGrado;

  // Comisaría
  String? comisaria;

  // Tipo de patrullaje
  TipoPatrullaje? tipoPatrullaje;

  // Vehículo
  String? placaVehiculo;
  TipoVehiculo? tipoVehiculo;

  // Turno
  Turno? turno;

  // Tiempos (guardar como ISO 8601 o sólo HH:mm si prefieres)
  String? horaAlerta; // "HH:mm" o ISO
  String? horaLlegada; // "HH:mm"
  String? horaRepliegue; // "HH:mm"

  // Fecha y metadatos
  DateTime? fecha; // fecha completa
  String? diaSemana; // opcional (Lunes, Martes...)
  String? mes; // opcional (Enero, Febrero...)
  String? codigoOcu; // CÓD. OCU

  // Otros campos libres (por si quieres añadir)
  

  GeneralidadesModel({
    this.id,
    required this.serenoDni,
    required this.serenoApellidos,
    required this.serenoNombres,
    required this.departamento,
    required this.provincia,
    required this.distrito,
    List<Origen>? origenes,
    this.modalidadPatrullaje,

    // Datos del policia
    this.infoPnpApellidos,
    this.infoPnpNombres,
    this.infoPnpGrado,
    this.comisaria,

    // Datos del vehiculo
    this.tipoPatrullaje,
    this.placaVehiculo,
    this.tipoVehiculo,

    // Fecha y Hora
    this.turno,
    this.horaAlerta,
    this.horaLlegada,
    this.horaRepliegue,
    this.fecha,
    this.diaSemana,
    this.mes,
    this.codigoOcu,
   
  }) : origenes = origenes ?? [];

  // Conversión enum <-> string para almacenar
  static String origenToString(Origen o) => o.toString().split('.').last;
  static Origen origenFromString(String s) =>
      Origen.values.firstWhere((e) => e.toString().split('.').last == s);

  static String modalidadToString(ModalidadPatrullaje m) =>
      m.toString().split('.').last;
  static ModalidadPatrullaje modalidadFromString(String s) =>
      ModalidadPatrullaje.values.firstWhere(
        (e) => e.toString().split('.').last == s,
      );

  static String tipoPatrullajeToString(TipoPatrullaje t) =>
      t.toString().split('.').last;
  static TipoPatrullaje tipoPatrullajeFromString(String s) => TipoPatrullaje
      .values
      .firstWhere((e) => e.toString().split('.').last == s);

  static String tipoVehiculoToString(TipoVehiculo t) =>
      t.toString().split('.').last;
  static TipoVehiculo tipoVehiculoFromString(String s) =>
      TipoVehiculo.values.firstWhere((e) => e.toString().split('.').last == s);

  static String turnoToString(Turno t) => t.toString().split('.').last;
  static Turno turnoFromString(String s) =>
      Turno.values.firstWhere((e) => e.toString().split('.').last == s);

  // Map para SQLite (sqflite espera Map<String, dynamic>)
  Map<String, dynamic> toMap() {
    return {
      'gen_id': id,
      'gen_sereno_dni': serenoDni,
      'gen_sereno_apellidos': serenoApellidos,
      'gen_sereno_nombres': serenoNombres,
      'gen_departamento': departamento,
      'gen_provincia': provincia,
      'gen_distrito': distrito,
      // Guardamos origenes como CSV de strings
      'gen_origenes': origenes.map((o) => origenToString(o)).join(','),
      'gen_modalidad_patrullaje':
          modalidadPatrullaje != null
              ? modalidadToString(modalidadPatrullaje!)
              : null,
      'gen_pnp_apellidos': infoPnpApellidos,
      'gen_pnp_nombres': infoPnpNombres,
      'gen_pnp_grado': infoPnpGrado,
      'gen_pnp_comisaria': comisaria,
      'gen_tipo_patrullaje':
          tipoPatrullaje != null
              ? tipoPatrullajeToString(tipoPatrullaje!)
              : null,
      'gen_placa_vehiculo': placaVehiculo,
      'gen_tipo_vehiculo':
          tipoVehiculo != null ? tipoVehiculoToString(tipoVehiculo!) : null,
      'gen_turno': turno != null ? turnoToString(turno!) : null,
      'gen_hora_alerta': horaAlerta,
      'gen_hora_llegada': horaLlegada,
      'gen_hora_repliegue': horaRepliegue,
      'gen_fecha_incidente': fecha?.toIso8601String(),
      'gen_dia_semana': diaSemana,
      'gen_mes': mes,
      'gen_cod_ocurrencia': codigoOcu,
      
    };
  }

  factory GeneralidadesModel.fromMap(Map<String, dynamic> map) {
    List<Origen> parsedOrigenes = [];
    if (map['origenes'] != null && (map['origenes'] as String).isNotEmpty) {
      parsedOrigenes =
          (map['origenes'] as String)
              .split(',')
              .where((s) => s.trim().isNotEmpty)
              .map((s) => origenFromString(s.trim()))
              .toList();
    }

    return GeneralidadesModel(
      id: map['gen_id'] as int?,
      serenoDni: map['gen_sereno_dni'] ?? '',
      serenoApellidos: map['gen_sereno_apellidos'] ?? '',
      serenoNombres: map['gen_sereno_nombres'] ?? '',
      departamento: map['gen_departamento'] ?? '',
      provincia: map['gen_provincia'] ?? '',
      distrito: map['gen_distrito'] ?? '',
      origenes: parsedOrigenes,
      modalidadPatrullaje:
          map['gen_origenes'] != null
              ? modalidadFromString(map['gen_modalidad_patrullaje'])
              : null,
      infoPnpApellidos: map['gen_pnp_apellidos'],
      infoPnpNombres: map['gen_pnp_nombres'],
      infoPnpGrado: map['gen_pnp_grado'],
      comisaria: map['gen_pnp_comisaria'],
      tipoPatrullaje:
          map['gen_tipo_patrullaje'] != null
              ? tipoPatrullajeFromString(map['gen_tipo_patrullaje'])
              : null,
      placaVehiculo: map['gen_placa_vehiculo'],
      tipoVehiculo:
          map['gen_tipo_vehiculo'] != null
              ? tipoVehiculoFromString(map['gen_tipo_vehiculo'])
              : null,
      turno: map['gen_turno'] != null ? turnoFromString(map['gen_turno']) : null,
      horaAlerta: map['gen_hora_alerta'],
      horaLlegada: map['gen_hora_llegada'],
      horaRepliegue: map['gen_hora_repliegue'],
      fecha: map['gen_fecha_incidente'] != null ? DateTime.parse(map['gen_fecha_incidente']) : null,
      diaSemana: map['gen_dia_semana'],
      mes: map['gen_mes'],
      codigoOcu: map['gen_cod_ocurrencia'],
  
    );
  }

  String toJson() => json.encode(toMap());
  factory GeneralidadesModel.fromJson(String source) =>
      GeneralidadesModel.fromMap(json.decode(source));
}
