import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'trailer.dart';

part 'film_info_model.g.dart';

@JsonSerializable()
class FilmInfoModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final double rating;
  final String ageRating;
  final List<String> genres;
  final String premierDate;
  final List<Trailer> trailers;
  final String poster;

  FilmInfoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.ageRating,
    required this.genres,
    required this.premierDate,
    required this.trailers,
    required this.poster,
  });

  factory FilmInfoModel.fromJson(Map<String, dynamic> json) => _$FilmInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilmInfoModelToJson(this);
  
  @override
  List<Object?> get props => [id, name, description, rating, ageRating, genres, premierDate, trailers, poster];
}