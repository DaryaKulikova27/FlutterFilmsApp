part of 'film_info_bloc.dart';

abstract class FilmInfoEvent extends Equatable {}

class SearchFilmById extends FilmInfoEvent {
  final int id;

  SearchFilmById({
    required this.id
  });

  @override
  List<Object?> get props => [id];
}