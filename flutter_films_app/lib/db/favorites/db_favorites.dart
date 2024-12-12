import 'package:films_app/db/db.dart';
import '../../repositories/search_films/models/models.dart';

class DbFavorites {
  Future<void> addToFavorites(Film film) async {
    await DB.instance.createUpdate(film);
  }

  Future<void> removeFromFavorites(int id) async {
    var model = await DB.instance.get<Film>(id);
    if (model != null) {
      await DB.instance.delete(model);
    } else {
      throw Exception('Item not found');
    }
  }

  Future<List<Film>> getAllFavorites({
    int skip = 0,
  }) async {
    var items = await DB.instance.getAll<Film>(
      skip: skip,
      take: null,
    );

    return items.toList();
  }

  Future<bool> isFavorite(int id) async {
    var res = await DB.instance.get<Film>(id);
    return res != null;
  }
}