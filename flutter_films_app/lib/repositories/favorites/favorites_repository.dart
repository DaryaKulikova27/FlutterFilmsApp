import 'package:films_app/db/favorites/db_favorites.dart';
import 'package:films_app/repositories/favorites/favorites.dart';
import 'package:films_app/repositories/search_films/models/film.dart';

class FavoritesRepository implements AbstractFavoritesRepository{
  final _dbService = DbFavorites();

  @override
  Future<void> addToFavorites(Film film) async {
    await _dbService.addToFavorites(film);
  }

  @override
  Future<void> removeFromFavorites(Film film) async {
    await _dbService.removeFromFavorites(film.id);
  }

  @override
  Future<bool> isFavorite(Film film) async {
    return await _dbService.isFavorite(film.id);
  }

  @override
  Future<List<Film>> getAllFavorites() async {
    return await _dbService.getAllFavorites();
  }
}