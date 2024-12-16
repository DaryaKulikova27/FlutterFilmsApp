import 'package:films_app/repositories/search_films/search_films.dart';
import 'package:dio/dio.dart';

class SearchFilmsRepository implements AbstractFilmsRepository {

  final Dio dio;
  SearchFilmsRepository({
    required this.dio
  });
  
  @override
  Future<List<Film>> searchFilms(String filmName, int currentPage) async {
    const apiKey = 'KCSGV2J-HGTMRV3-JJGE791-XKKS3MW';
    final query = Uri.encodeComponent(filmName.trim());
    final url =
        'https://api.kinopoisk.dev/v1.4/movie/search?page=$currentPage&limit=6&query=$query';
    final response = await dio.get(
      url,
      options: Options(headers: {'X-API-KEY': apiKey}),
    );
    final data = response.data as Map<String, dynamic>;
    final docs = data['docs'] as List<dynamic>;

    List<Film> films = docs.map((film) {
      final id = film['id'] as int? ?? 0;
      final name = film['name'] as String? ?? 'NoName';
      final alternativeName = film['alternativeName'] as String? ?? 'NoAlternativeName';
      final type = film['type'] as String? ?? 'NoType';
      final year = film['year'] as int? ?? 0;
      final description = film['description'] as String? ?? '';
      final shortDescription = film['shortDescription'] as String? ?? '';
      final ageRating = film['ageRating'] as int? ?? 0;
      final poster = film['poster'] as Map<String, dynamic>? ?? {};
      final posterUrl = poster['url'] as String? ?? '';

      final genresList = film['genres'] as List<dynamic>? ?? [];
      final genres = genresList.map((e) => e['name'] as String? ?? '').toList();

      final countriesList = film['countries'] as List<dynamic>? ?? [];
      final countries = countriesList.map((e) => e['name'] as String? ?? '').toList();

      return Film(
          id: id,
          name: name,
          alternativeName: alternativeName,
          type: type,
          year: year,
          description: description,
          shortDescription: shortDescription,
          ageRating: ageRating,
          posterUrl: posterUrl,
          genres: genres,
          countries: countries
        );
    }).toList();

    // final testValuesFilms = [
    //   const Film(
    //     id: 689,
    //     name: "Гарри Поттер и философский камень", 
    //     alternativeName: "Harry Potter and the Sorcerer's Stone", 
    //     type: "movie", 
    //     year: 2001, 
    //     description: "Жизнь десятилетнего Гарри Поттера нельзя назвать сладкой: родители умерли, едва ему исполнился год, а от дяди и тёти, взявших сироту на воспитание, достаются лишь тычки да подзатыльники. Но в одиннадцатый день рождения Гарри всё меняется. Странный гость, неожиданно появившийся на пороге, приносит письмо, из которого мальчик узнаёт, что на самом деле он - волшебник и зачислен в школу магии под названием Хогвартс. А уже через пару недель Гарри будет мчаться в поезде Хогвартс-экспресс навстречу новой жизни, где его ждут невероятные приключения, верные друзья и самое главное — ключ к разгадке тайны смерти его родителей.", 
    //     shortDescription: "Гарри поступает в школу магии Хогвартс и заводит друзей. Первая часть большой франшизы о маленьком волшебнике", 
    //     ageRating: 12, 
    //     posterUrl: "https://image.openmoviedb.com/kinopoisk-images/1898899/27ed5c19-a045-49dd-8624-5f629c5d96e0/orig", 
    //     genres: ["фэнтези", "приключения", "семейный"], 
    //     countries: ["Великобритания", "США"])
    // ];

    return films;    
  }
}