part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {}

class FavoritesStateInitial extends FavoritesState {
  @override
  List<Object?> get props => [];
}

class FavoritesStateChecked extends FavoritesState {
  final bool isFavorite;
  FavoritesStateChecked({required this.isFavorite});
  
  @override
  List<Object?> get props => [isFavorite];
}

class FavoritesStateLoaded extends FavoritesState {
  final List<Film> favorites;
  FavoritesStateLoaded({required this.favorites});
  
  @override
  List<Object?> get props => [favorites];
}

class FavoritesStateError extends FavoritesState {
  final String message;
  FavoritesStateError({required this.message});
  
  @override
  List<Object?> get props => [];
}