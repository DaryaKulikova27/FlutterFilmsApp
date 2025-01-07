import 'package:films_app/repositories/film_info/models/film_info_model.dart';

abstract class AbstractFilmsRepository {
  Future<List<FilmInfoModel>> searchFilms(String filmName, int currentPage);
}