// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmInfoModel _$FilmInfoModelFromJson(Map<String, dynamic> json) =>
    FilmInfoModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      rating: json['rating']?['kp'] + 0.0 ?? 0.0,
      ageRating: json['ageRating'] != null ? '${json['ageRating']}+' : 'н.д.',
      genres: List.generate(json['genres'].length, (index) => json['genres'][index]['name']),
      premierDate: json['premiere']['world'] ?? '',
      trailers: List.generate(
          json['videos']?['trailers'].length ?? 0,
          (index) => Trailer.fromJson(
            json['videos']?['trailers']?[index],
          ),
        ),
      poster: json['backdrop']?['url'] ?? '',
    );

Map<String, dynamic> _$FilmInfoModelToJson(FilmInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'rating': instance.rating,
      'ageRating': instance.ageRating,
      'genres': instance.genres,
      'premierDate': instance.premierDate,
      'trailers': instance.trailers,
      'poster': instance.poster,
    };
