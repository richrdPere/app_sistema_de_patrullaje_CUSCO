class MediosEmpleadosModel {
  final int? id;
  final String? resultados;
  final String? consecuencias;
  final String? lugar_ocupacional;
  final String? medios_utilizados;

  MediosEmpleadosModel({
    this.id,
    required this.resultados,
    required this.consecuencias,
    required this.lugar_ocupacional,
    required this.medios_utilizados,
  });

  // ---- JSON serialization ----
  factory MediosEmpleadosModel.fromJson(Map<String, dynamic> json) {
    return MediosEmpleadosModel(
      id: json['id'],
      resultados: json['resultados'],
      consecuencias: json['consecuencias'],
      lugar_ocupacional: json['lugar_ocupacional'] ?? '',
      medios_utilizados: json['medios_utilizados'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resultados': resultados,
      'consecuencias': consecuencias,
      'lugar_ocupacional': lugar_ocupacional,
      'medios_utilizados': medios_utilizados,
    };
  }

  // Convertir objeto a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resultados': resultados,
      'consecuencias': consecuencias,
      'lugar_ocupacional': lugar_ocupacional,
      'medios_utilizados': medios_utilizados,
    };
  }

  // Crear objeto desde Map de SQLite
  factory MediosEmpleadosModel.fromMap(Map<String, dynamic> map) {
    return MediosEmpleadosModel(
      id: map['id'],
      resultados: map['resultados'],
      consecuencias: map['consecuencias'],
      lugar_ocupacional: map['lugar_ocupacional'],
      medios_utilizados: map['medios_utilizados'],
    );
  }
}
