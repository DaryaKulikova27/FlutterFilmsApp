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
  SearchFilmsStateLoaded({
    required this.films,
  });

  final List<Film> films;
  
  @override
  List<Object?> get props => [films];
}

class SearchFilmsStateLoadingFailure extends SearchFilmsState {
  SearchFilmsStateLoadingFailure({
    required this.exception,
  });
  
  final Object? exception;
  
  @override
  List<Object?> get props => [exception];
}