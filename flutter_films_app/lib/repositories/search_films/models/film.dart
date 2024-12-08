import 'package:equatable/equatable.dart';

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
  final List<NameInfo> genres;
  final List<NameInfo> countries;
  
  @override
  List<Object?> get props => [name, alternativeName, type, year, description, shortDescription, ageRating, posterUrl, genres, countries];
}


class NameInfo extends Equatable {
  const NameInfo({
    required this.name
  });

  final String name;

  @override
  List<Object?> get props => [name];
}
