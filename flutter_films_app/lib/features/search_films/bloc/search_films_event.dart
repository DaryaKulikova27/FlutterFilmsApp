part of 'search_films_bloc.dart';

abstract class SearchFilmsEvent extends Equatable {}

class LoadFilmsList extends SearchFilmsEvent {
  LoadFilmsList({
    required this.filmName
  });

  final String filmName;
  
  @override
  List<Object?> get props => [filmName];
}