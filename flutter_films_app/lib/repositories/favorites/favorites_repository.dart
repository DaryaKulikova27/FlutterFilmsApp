import 'package:crypto_coins_list/repositories/favorites/favorites.dart';
import 'package:crypto_coins_list/repositories/search_films/models/film.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesRepository implements AbstractFavoritesRepository{
  static const String _tableName = 'favorites';
  late Database _database;

  Future<void> init() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'favorites.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            alternativeName TEXT,
            type TEXT,
            year INTEGER,
            description TEXT,
            shortDescription TEXT,
            ageRating INTEGER,
            posterUrl TEXT,
            genres TEXT,
            countries TEXT
          )
        ''');
      },
    );
  }

  Future<void> addToFavorites(Film film) async {
    await _database.insert(
      _tableName,
      film.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFromFavorites(Film film) async {
    await _database.delete(
      _tableName,
      where: 'name = ?',
      whereArgs: [film.name],
    );
  }

  Future<bool> isFavorite(Film film) async {
    final List<Map<String, dynamic>> result = await _database.query(
      _tableName,
      where: 'name = ?',
      whereArgs: [film.name],
    );
    return result.isNotEmpty;
  }

  Future<List<Film>> getAllFavorites() async {
    final List<Map<String, dynamic>> results = await _database.query(_tableName);
    return results.map((map) => Film.fromMap(map)).toList();
  }
}