part of 'film_info_bloc.dart';

abstract class FilmInfoState extends Equatable {}

class FilmInfoInitial extends FilmInfoState {
  @override
  List<Object?> get props => [];
}

class FilmInfoStateLoading extends FilmInfoState {
  @override
  List<Object?> get props => [];
}

class FilmInfoStateLoaded extends FilmInfoState {
  final FilmInfoModel film;

  FilmInfoStateLoaded({
    required this.film
  });
  
  @override
  List<Object?> get props => [film];
}

class FilmInfoStateLoadingFailure extends FilmInfoState {
  FilmInfoStateLoadingFailure({
    required this.exception,
  });
  
  final Object? exception;
  
  @override
  List<Object?> get props => [exception];
}