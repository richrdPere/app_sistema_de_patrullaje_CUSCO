class MediosEmpleadosModel {
  final int? id;
  final String? tipo_via;
  final String? direccion;
  final String? referencia;
  final String? manzana;
  final String? lote;
  final String? tipo_zona;
  final String? nombre_zona;
  final String? sector_patrullaje;
  final String? lat;
  final String? lon;

  MediosEmpleadosModel({
    this.id,
    required this.tipo_via,
    required this.direccion,
    required this.referencia,
    required this.manzana,
    required this.lote,
    required this.tipo_zona,
    required this.nombre_zona,
    required this.sector_patrullaje,
    required this.lat,
    required this.lon,
  });

  // ---- JSON serialization ----
  factory MediosEmpleadosModel.fromJson(Map<String, dynamic> json) {
    return MediosEmpleadosModel(
      id: json['id'],
      tipo_via: json['tipo_via'],
      direccion: json['direccion'],
      referencia: json['referencia'] ?? '',
      manzana: json['manzana'] ?? '',
      lote: json['lote'] ?? '',
      tipo_zona: json['tipo_zona'] ?? '',
      nombre_zona: json['nombre_zona'] ?? '',
      sector_patrullaje: json['sector_patrullaje'] ?? '',
      lat: json['lat'] ?? '',
      lon: json['lon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo_via': tipo_via,
      'direccion': direccion,
      'referencia': referencia,
      'manzana': manzana,
      'lote': lote,
      'tipo_zona': tipo_zona,
      'nombre_zona': nombre_zona,
      'sector_patrullaje': sector_patrullaje,
      'lat': lat,
      'lon': lon,
    };
  }

  // Convertir objeto a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo_via': tipo_via,
      'direccion': direccion,
      'referencia': referencia,
      'manzana': manzana,
      'lote': lote,
      'tipo_zona': tipo_zona,
      'nombre_zona': nombre_zona,
      'sector_patrullaje': sector_patrullaje,
      'lat': lat,
      'lon': lon,
    };
  }

  // Crear objeto desde Map de SQLite
  factory MediosEmpleadosModel.fromMap(Map<String, dynamic> map) {
    return MediosEmpleadosModel(
      id: map['id'],
      tipo_via: map['tipo_via'],
      direccion: map['direccion'],
      referencia: map['referencia'],
      manzana: map['manzana'],
      lote: map['lote'],
      tipo_zona: map['tipo_zona'],
      nombre_zona: map['nombre_zona'],
      sector_patrullaje: map['sector_patrullaje'],
      lat: map['lat'],
      lon: map['lon'],
    );
  }
}
