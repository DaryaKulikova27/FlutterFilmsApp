part of 'search_films_bloc.dart';

abstract class SearchFilmsState extends Equatable {}

class SearchFilmsStateInitial extends SearchFilmsState {
  @override
  List<Object?> get props => [];
}

class SearchFilmsStateLoading extends SearchFilmsState {
  @override
  List<Object?> get props => [];
}

class SearchFilmsStateLoaded extends SearchFilmsState {
  final List<Film> films;
  final bool hasMore;
  final bool isLoadingMore;

  SearchFilmsStateLoaded({
    required this.films,
    required this.hasMore,
    required this.isLoadingMore,
  });
  
  @override
  List<Object?> get props => [films, hasMore, isLoadingMore];
}


class SearchFilmsStateLoadingFailure extends SearchFilmsState {
  SearchFilmsStateLoadingFailure({
    required this.exception,
  });
  
  final Object? exception;
  
  @override
  List<Object?> get props => [exception];
}