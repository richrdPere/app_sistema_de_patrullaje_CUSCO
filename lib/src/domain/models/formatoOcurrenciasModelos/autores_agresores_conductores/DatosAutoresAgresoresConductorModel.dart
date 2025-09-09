import 'dart:convert';
import 'package:app_sistema_de_patrullaje/src/domain/models/formatoOcurrenciasModelos/autores_agresores_conductores/AutorAgresorConductorModel.dart';

class DatosAutoresAgresoresConductor {
  bool identificado; // TRUE si identificado, FALSE si no identificado
  List<AutorAgresorConductorModel> autores;

  // Conteos automáticos
  int get cantidadTotal => autores.length;
  int get cantidadMasculino =>
      autores.where((a) => a.genero == Genero.masculino).length;
  int get cantidadFemenino =>
      autores.where((a) => a.genero == Genero.femenino).length;
  int get cantidadMayores =>
      autores.where((a) => a.edad != null && a.edad! >= 18).length;
  int get cantidadMenores =>
      autores.where((a) => a.edad != null && a.edad! < 18).length;

  DatosAutoresAgresoresConductor({
    required this.identificado,
    List<AutorAgresorConductorModel>? autores,
  }) : autores = autores ?? [];

  Map<String, dynamic> toMap() {
    return {
      'identificado': identificado ? 1 : 0,
      'autores': autores.map((a) => a.toMap()).toList(),
    };
  }

  factory DatosAutoresAgresoresConductor.fromMap(Map<String, dynamic> map) {
    return DatosAutoresAgresoresConductor(
      identificado: (map['identificado'] ?? 0) == 1,
      autores: map['autores'] != null
          ? List<AutorAgresorConductorModel>.from(
              (map['autores'] as List)
                  .map((a) => AutorAgresorConductorModel.fromMap(a)),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory DatosAutoresAgresoresConductor.fromJson(String source) =>
      DatosAutoresAgresoresConductor.fromMap(json.decode(source));
}
