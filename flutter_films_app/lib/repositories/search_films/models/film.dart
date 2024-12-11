import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'film.g.dart';

@JsonSerializable()
class Film extends Equatable {
  const Film ({
    required this.name,
    required this.alternativeName,
    required this.type,
    required this.year,
    required this.description,
    required this.shortDescription,
    required this.ageRating,
    required this.posterUrl,
    required this.genres,
    required this.countries
  });

  final String name;
  final String alternativeName;
  final String type;
  final int year;
  final String description;
  final String shortDescription;
  final int ageRating;
  final String posterUrl;
  final List<String> genres;
  final List<String> countries;

  factory Film.fromJson(Map<String, dynamic> json) => _$FilmFromJson(json);

  Map<String, dynamic> toJson() => _$FilmToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'alternativeName': alternativeName,
      'type': type,
      'year': year,
      'description': description,
      'shortDescription': shortDescription,
      'ageRating': ageRating,
      'posterUrl': posterUrl,
      'genres': genres,
      'countries': countries,
    };
  }

  factory Film.fromMap(Map<String, dynamic> map) {
    return Film(
      name: map['name'] as String,
      alternativeName: map['alternativeName'] as String,
      type: map['type'] as String,
      year: map['year'] as int,
      description: map['description'] as String,
      shortDescription: map['shortDescription'] as String,
      ageRating: map['ageRating'] as int,
      posterUrl: map['posterUrl'] as String,
      genres: List<String>.from(map['genres']),
      countries: List<String>.from(map['countries']),
    );
  }
  
  @override
  List<Object?> get props => [name, alternativeName, type, year, description, shortDescription, ageRating, posterUrl, genres, countries];
}
