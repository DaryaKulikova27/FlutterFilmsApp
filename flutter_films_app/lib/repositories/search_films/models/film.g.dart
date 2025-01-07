// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Film _$FilmFromJson(Map<String, dynamic> json) => Film(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      alternativeName: json['alternativeName'] as String,
      type: json['type'] as String,
      year: (json['year'] as num).toInt(),
      description: json['description'] as String,
      shortDescription: json['shortDescription'] as String,
      ageRating: (json['ageRating'] as num).toInt(),
      posterUrl: json['posterUrl'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      countries:
          (json['countries'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FilmToJson(Film instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'alternativeName': instance.alternativeName,
      'type': instance.type,
      'year': instance.year,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'ageRating': instance.ageRating,
      'posterUrl': instance.posterUrl,
      'genres': instance.genres,
      'countries': instance.countries,
    };
