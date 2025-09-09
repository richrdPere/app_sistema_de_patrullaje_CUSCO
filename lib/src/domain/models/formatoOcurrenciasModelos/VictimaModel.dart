class VictimaModel {
  final int? id;
  final int incidenteId; // FK: Referencia al incidente
  final String nombre;
  final int edad;
  final String? caracteristicasFisicas;
  final String? relacionVictimaVictimario;
  final String sexo; // "M" o "F"
  final bool esMayorEdad;

  VictimaModel({
    this.id,
    required this.incidenteId,
    required this.nombre,
    required this.edad,
    this.caracteristicasFisicas,
    this.relacionVictimaVictimario,
    required this.sexo,
    required this.esMayorEdad,
  });

  // Convertir Victima a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'incidente_id': incidenteId,
      'nombre': nombre,
      'edad': edad,
      'caracteristicas_fisicas': caracteristicasFisicas,
      'relacion_victima_victimario': relacionVictimaVictimario,
      'sexo': sexo,
      'es_mayor_edad': esMayorEdad ? 1 : 0,
    };
  }

  // Crear Victima desde Map
  factory VictimaModel.fromMap(Map<String, dynamic> map) {
    return VictimaModel(
      id: map['id'],
      incidenteId: map['incidente_id'],
      nombre: map['nombre'],
      edad: map['edad'],
      caracteristicasFisicas: map['caracteristicas_fisicas'],
      relacionVictimaVictimario: map['relacion_victima_victimario'],
      sexo: map['sexo'],
      esMayorEdad: map['es_mayor_edad'] == 1,
    );
  }
}
