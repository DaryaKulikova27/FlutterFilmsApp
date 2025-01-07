import 'package:films_app/repositories/film_info/models/film_info_model.dart';

abstract class AbstractFilmInfoRepository {
  Future<FilmInfoModel> getFilmById(int id);
}