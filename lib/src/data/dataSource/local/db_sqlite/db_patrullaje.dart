import 'package:app_sistema_de_patrullaje/src/data/dataSource/local/db_sqlite/tablas_formato_ocurrencias.dart';
import 'package:app_sistema_de_patrullaje/src/domain/models/formatoOcurrenciasModelos/GeneralidadesModel.dart';
import 'package:app_sistema_de_patrullaje/src/domain/models/formatoOcurrenciasModelos/autores_agresores_conductores/DatosAutoresAgresoresConductorModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Database Script Formato Ocurrencia

class DatabaseFormatoOcurrencia {
  static final DatabaseFormatoOcurrencia instance =
      DatabaseFormatoOcurrencia._init();
  static Database? _database;

  DatabaseFormatoOcurrencia._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('FormatoOcurrencia.db');
    return _database!;
  }

  Future? get db => null;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(DatabaseScriptsFormatoOcurrencia.createGeneralidadesTable);
    await db.execute(DatabaseScriptsFormatoOcurrencia.createAgresoresTable);
    await db.execute(DatabaseScriptsFormatoOcurrencia.createVictimasTable);
    await db.execute(DatabaseScriptsFormatoOcurrencia.createDatosAgresorTable);
    await db.execute(DatabaseScriptsFormatoOcurrencia.createDatosVictimaTable);
    await db.execute(
      DatabaseScriptsFormatoOcurrencia.createDatosOcurrenciaTable,
    );
    await db.execute(
      DatabaseScriptsFormatoOcurrencia.createDatosGeorreferenciacionTable,
    );
    await db.execute(
      DatabaseScriptsFormatoOcurrencia.createRegistroOcurrenciaTable,
    );
  }

  // ==============================================================
  // ============= MÉTODOS CRUD GENÉRICOS =========================
  // ==============================================================

  // INSERTAR
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final dbClient = await database;
    return await dbClient.insert(
      table,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ACTUALIZAR
  Future<int> update(
    String table,
    Map<String, dynamic> row,
    String where,
    List whereArgs,
  ) async {
    final dbClient = await database;
    return await dbClient.update(
      table,
      row,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // ELIMINAR
  Future<int> delete(String table, String where, List whereArgs) async {
    final dbClient = await database;
    return await dbClient.delete(table, where: where, whereArgs: whereArgs);
  }

  // OBTENER TODOS LOS REGISTROS
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final dbClient = await database;
    return await dbClient.query(table);
  }

  // OBTENER REGISTROS POR ID
  Future<Map<String, dynamic>?> queryById(
    String table,
    String columnId,
    int id,
  ) async {
    final dbClient = await database;
    final res = await dbClient.query(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return res.isNotEmpty ? res.first : null;
  }

  // ==============================================================
  // ============== FUNCIONES ESPECÍFICAS =========================
  // ==============================================================

  // ===========================================
  // 1.- GENERALIDADES
  // ===========================================
  Future<int> insertGeneralidades(GeneralidadesModel generalidad) async {
    final id = await insert('ss_generalidades', generalidad.toMap());

    return id;
  }

  Future<List<GeneralidadesModel>> getGeneralidades() async {
    final maps = await queryAll('ss_generalidades');
    return maps.map((m) => GeneralidadesModel.fromMap(m)).toList();
  }

  Future<GeneralidadesModel?> getGeneralidadById(int id) async {
    final map = await queryById('ss_generalidades', 'gen_id', id);
    return map != null ? GeneralidadesModel.fromMap(map) : null;
  }

  Future<int> updateGeneralidad(GeneralidadesModel generalidad) async =>
      await update('ss_generalidades', generalidad.toMap(), 'gen_id = ?', [
        generalidad.id,
      ]);

  Future<int> deleteGeneralidad(int id) async =>
      await delete('ss_generalidades', 'gen_id = ?', [id]);

  // ===========================================
  // 2.- AGRESORES
  // ===========================================
  Future<int> insertAgresores(DatosAutoresAgresoresConductor agresor) async {
    final id = await insert('ss_agresores', agresor.toMap());

    return id;
  }

  Future<List<DatosAutoresAgresoresConductor>> getAgresores() async {
    final maps = await queryAll('ss_agresores');
    return maps.map((m) => DatosAutoresAgresoresConductor.fromMap(m)).toList();
  }

  Future<DatosAutoresAgresoresConductor?> getAgresoresById(int id) async {
    final map = await queryById('ss_agresores', 'agr_id', id);
    return map != null ? DatosAutoresAgresoresConductor.fromMap(map) : null;
  }

  Future<int> updateAgresores(DatosAutoresAgresoresConductor agresor) async =>
      await update('ss_agresores', agresor.toMap(), 'agr_id = ?', [
        agresor.identificado,
      ]);

  Future<int> deleteAgresores(int id) async =>
      await delete('ss_agresores', 'agr_id = ?', [id]);
}
