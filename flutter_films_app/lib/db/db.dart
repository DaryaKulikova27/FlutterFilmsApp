import 'package:crypto_coins_list/db/models/db_model.dart';
import 'package:crypto_coins_list/repositories/search_films/models/models.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._(); 
  static final DB instance = DB._();
  static late Database _db;
  static bool _isInitialized = false;

  static final _factories = <Type, Function(Map<String, dynamic> map)>{
    Film: (map) => Film.fromMap(map),
  };

  Future init() async {
    if (!_isInitialized) {
      var databasePath = await getDatabasesPath();

      var path = join(databasePath, "db_v1.0.2.db");

      _db = await openDatabase(path, version: 1, onCreate: _createDB);
      _isInitialized = true;
    }
  }

  Future _createDB(Database db, int version) async {
    var dbInitScript = await rootBundle.loadString('assets/db_init.sql');

    dbInitScript.split(';').forEach((element) async {
      if (element.isNotEmpty) {
        await db.execute(element);
      }
    });
  }

  String _dbName(Type type) {
    if (type == DbModel) {
      throw Exception("Type is required");
    }
    return "t_${(type).toString()}";
  }

  Future<int> insert<T extends DbModel>(T model) async => await _db.insert(
    _dbName(T), 
    model.toMap(), 
    conflictAlgorithm: ConflictAlgorithm.replace,
    nullColumnHack: null
  );

  Future<T?> get<T extends DbModel>(dynamic id) async {
    var res = await _db.query(
      _dbName(T),
      where: 'id = ? ',
      whereArgs: [id],
    );
    return res.isNotEmpty ? _factories[T]!(res.first) : null;
  }

  Future<Iterable<T>> getAll<T extends DbModel>({
    int? take,
    int? skip,
  }) async {
    Iterable<Map<String, dynamic>> query = await _db.query(
        _dbName(T),
        offset: skip, 
        limit: take,
      );

    var resList = query.map((e) => _factories[T]!(e)).cast<T>();

    return resList;
  }

  Future<int> update<T extends DbModel>(T model) async => _db.update(
    _dbName(T),
    model.toMap(),
    where: 'id = ?',
    whereArgs: [model.id],
  );

  Future<int> delete<T extends DbModel>(T model) async => _db.delete(
    _dbName(T),
    where: 'id = ?',
    whereArgs: [model.id],
  );

  Future<int> createUpdate<T extends DbModel>(T model) async {
    var dbItem = await get<T>(model.id);
    var res = dbItem == null ? insert(model) : update(model);
    return await res;
  }
}