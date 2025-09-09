class FormatoOcurrencia {
  // Paso 1: Generalidades
  String? fecha;
  String? hora;
  String? tipoIntervencion;

  // Paso 2: Autor/Agresor/Conductor(es)
  String? nombreAutor;
  String? dniAutor;
  String? descripcionAutor;

  // Paso 3: Víctima
  String? nombreVictima;
  String? dniVictima;
  String? telefonoVictima;

  // Paso 4: Relación Víctima
  String? relacionConVictima;

  // Paso 5: Datos Ocurrencia
  String? descripcionOcurrencia;
  String? mediosEmpleados;

  // Paso 6: Dirección y Georreferenciación
  String? direccion;
  double? latitud;
  double? longitud;

  Map<String, dynamic> toJson() {
    return {
      "fecha": fecha,
      "hora": hora,
      "tipoIntervencion": tipoIntervencion,
      "nombreAutor": nombreAutor,
      "dniAutor": dniAutor,
      "descripcionAutor": descripcionAutor,
      "nombreVictima": nombreVictima,
      "dniVictima": dniVictima,
      "telefonoVictima": telefonoVictima,
      "relacionConVictima": relacionConVictima,
      "descripcionOcurrencia": descripcionOcurrencia,
      "mediosEmpleados": mediosEmpleados,
      "direccion": direccion,
      "latitud": latitud,
      "longitud": longitud,
    };
  }
}
