import 'dart:convert';

enum Genero { masculino, femenino, desconocido }

class AutorAgresorConductorModel {
  String apellidosNombres;
  Genero genero;
  int? edad; // Puede ser null si no identificado
  String? placa;

  AutorAgresorConductorModel({
    required this.apellidosNombres,
    required this.genero,
    this.edad,
    this.placa,
  });

  Map<String, dynamic> toMap() {
    return {
      'apellidosNombres': apellidosNombres,
      'genero': genero.toString().split('.').last,
      'edad': edad,
      'placa': placa,
    };
  }

  factory AutorAgresorConductorModel.fromMap(Map<String, dynamic> map) {
    return AutorAgresorConductorModel(
      apellidosNombres: map['apellidosNombres'] ?? '',
      genero: Genero.values.firstWhere(
        (g) => g.toString().split('.').last == (map['genero'] ?? 'desconocido'),
        orElse: () => Genero.desconocido,
      ),
      edad: map['edad'] != null ? map['edad'] as int : null,
      placa: map['placa'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AutorAgresorConductorModel.fromJson(String source) =>
      AutorAgresorConductorModel.fromMap(json.decode(source));
}
