part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {}

class AddToFavorites extends FavoritesEvent {
  final Film film;
  AddToFavorites({
    required this.film
  });

  @override
  List<Object?> get props => [film];
}

class RemoveFromFavorites extends FavoritesEvent {
  final Film film;
  RemoveFromFavorites({required this.film});
  
  @override
  List<Object?> get props => [film];
}

class CheckFavoriteStatus extends FavoritesEvent {
  final Film film;
  CheckFavoriteStatus({required this.film});
  
  @override
  List<Object?> get props => [film];
}

class LoadFavorites extends FavoritesEvent {
  @override
  List<Object?> get props => [];
}