import 'package:films_app/repositories/search_films/models/film.dart';

abstract class AbstractFilmsRepository {
  Future<List<Film>> searchFilms(String filmName, int currentPage);
}