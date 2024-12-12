import 'package:films_app/repositories/search_films/models/film.dart';

abstract class AbstractFavoritesRepository {
  Future<void> addToFavorites(Film film);
  Future<void> removeFromFavorites(Film film);
  Future<bool> isFavorite(Film film);
  Future<List<Film>> getAllFavorites();
}