import 'package:films_app/repositories/film_info/abstract_film_info_repository.dart';
import 'package:films_app/repositories/film_info/models/film_info_model.dart';
import 'package:dio/dio.dart';

class FilmInfoRepository implements AbstractFilmInfoRepository {

  final Dio dio;
  FilmInfoRepository({
    required this.dio
  });

  @override
  Future<FilmInfoModel> getFilmById(int id) async {
    const apiKey = 'KCSGV2J-HGTMRV3-JJGE791-XKKS3MW';
    final url =
        'https://api.kinopoisk.dev/v1.4/movie/$id';
    final response = await dio.get(
      url,
      options: Options(headers: {'X-API-KEY': apiKey}),
    );

    return FilmInfoModel.fromJson(response.data);
  }
}