part of 'search_films_bloc.dart';

abstract class SearchFilmsEvent extends Equatable {}

class LoadFilmsList extends SearchFilmsEvent {
  final String filmName;

  LoadFilmsList({
    required this.filmName
  });

  @override
  List<Object?> get props => [filmName];
}

class LoadMoreFilms extends SearchFilmsEvent {
  final String filmName;

  LoadMoreFilms({
    required this.filmName
  });

  @override
  List<Object?> get props => [];
}

class ClearSearch extends SearchFilmsEvent {
  @override
  List<Object?> get props => [];
}