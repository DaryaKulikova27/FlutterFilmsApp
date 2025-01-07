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
      rating: (json['rating'] as num).toDouble(),
      ageRating: json['ageRating'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      premierDate: json['premierDate'] as String,
      trailers: (json['trailers'] as List<dynamic>)
          .map((e) => Trailer.fromJson(e as Map<String, dynamic>))
          .toList(),
      poster: json['poster'] as String,
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
