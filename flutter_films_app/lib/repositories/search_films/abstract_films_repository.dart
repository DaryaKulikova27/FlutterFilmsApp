import 'package:crypto_coins_list/repositories/search_films/models/film.dart';

abstract class AbstractFilmsRepository {
  Future<List<Film>> searchFilms(String filmName);
}