import 'package:films_app/repositories/film_info/abstract_film_info_repository.dart';
import 'package:films_app/repositories/film_info/models/film_info_model.dart';
import 'package:films_app/utils/api_manager.dart';

class FilmInfoRepository implements AbstractFilmInfoRepository {

  @override
  Future<FilmInfoModel> getFilmById(int id) async {
    var response = await apiManager.get(
      '/v1.4/movie/$id',
    );

    return FilmInfoModel.fromJson(response.data);
  }
}