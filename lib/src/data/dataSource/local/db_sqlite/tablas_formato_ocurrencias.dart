// Script SQL para crear las tablas en SQLite
class DatabaseScriptsFormatoOcurrencia {
  // 1.- ss_generalidades
  static const String createGeneralidadesTable = '''
  CREATE TABLE ss_generalidades (
    gen_id INTEGER PRIMARY KEY AUTOINCREMENT,
    gen_sereno_dni TEXT,
    gen_sereno_apellidos TEXT,
    gen_sereno_nombres TEXT,
    gen_departamento TEXT,
    gen_provincia TEXT,
    gen_distrito TEXT,
    gen_origenes TEXT,
    gen_modalidad_patrullaje TEXT,
    gen_pnp_apellidos TEXT,
    gen_pnp_nombres TEXT,
    gen_pnp_grado TEXT,
    gen_pnp_comisaria TEXT,
    gen_tipo_patrullaje TEXT,
    gen_placa_vehiculo TEXT,
    gen_tipo_vehiculo TEXT,
    gen_turno TEXT,
    gen_hora_alerta TEXT,
    gen_hora_llegada TEXT,
    gen_hora_repliegue TEXT,
    gen_fecha_incidente TEXT,
    gen_dia_semana TEXT,
    gen_mes TEXT,
    gen_cod_ocurrencia TEXT
  );
  ''';

  // 2.- ss_agresores
  static const String createAgresoresTable = '''
  CREATE TABLE ss_agresores (
    agr_id INTEGER PRIMARY KEY AUTOINCREMENT,
    agr_apellidos TEXT,
    agr_nombres TEXT,
    agr_edad TEXT,
    agr_genero TEXT,
    agr_placa TEXT
  );
  ''';

  // 3.- ss_victimas
  static const String createVictimasTable = '''
  CREATE TABLE ss_victimas (
    vic_id INTEGER PRIMARY KEY AUTOINCREMENT,
    vic_apellidos TEXT,
    vic_nombres TEXT,
    vic_edad TEXT,
    vic_genero TEXT
  );
  ''';

  // 4.- ss_datos_agresor
  static const String createDatosAgresorTable = '''
  CREATE TABLE ss_datos_agresor (
    dag_id INTEGER PRIMARY KEY AUTOINCREMENT,
    dag_identidad TEXT,
    dag_agresor_id INTEGER,
    dag_cant_masculino INTEGER,
    dag_cant_femenino INTEGER,
    dag_cant_mayores_edad INTEGER,
    dag_cant_menores_edad INTEGER,
    dag_cant_total INTEGER
    );
    ''';

  // 5.- ss_datos_victima
  static const String createDatosVictimaTable = '''
  CREATE TABLE ss_datos_victima (
    dvi_id INTEGER PRIMARY KEY AUTOINCREMENT,
    dvi_comunidad TEXT,
    dvi_victima_id TEXT,
    dvi_cant_masculino INTEGER,
    dvi_cant_femenino INTEGER,
    dvi_cant_mayores_edad INTEGER,
    dvi_cant_menores_edad INTEGER,
    dvi_cant_total INTEGER,
    dvi_relacion_victimario TEXT
  );
  ''';

  // 6.- ss_datos_ocurrencia
  static const String createDatosOcurrenciaTable = '''
  CREATE TABLE ss_datos_ocurrencia (
    doc_id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_resultados TEXT,
    doc_consecuencias TEXT,
    doc_lugar_ocurrencia TEXT,
    doc_medio_utilizado TEXT
  );
  ''';

  // 7.- ss_datos_georreferenciacion
  static const String createDatosGeorreferenciacionTable = '''
  CREATE TABLE ss_datos_georreferenciacion (
    geo_id INTEGER PRIMARY KEY AUTOINCREMENT,
    geo_tipo_via TEXT,
    geo_direccion TEXT,
    geo_referencia TEXT,
    geo_manzana TEXT,
    geo_lote TEXT,
    geo_tipo_zona TEXT,
    geo_nombre_zona TEXT,
    geo_sector_patrullaje TEXT,
    geo_lat TEXT,
    geo_long TEXT
  );
  ''';

  // 8.- ss_registro_ocurrencia
  static const String createRegistroOcurrenciaTable = '''
CREATE TABLE ss_registro_ocurrencia (
  reo_id INTEGER PRIMARY KEY AUTOINCREMENT,
  reo_id_generalidades INTEGER, 
  reo_id_datos_agresor INTEGER,
  reo_id_datos_victima INTEGER,
  reo_id_datos_ocurrencia INTEGER,
  reo_id_datos_georreferenciacion INTEGER,
  reo_datos_importantes TEXT
);
''';
}
