import 'package:films_app/repositories/favorites/favorites.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/search_films/models/models.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final AbstractFavoritesRepository favoritesRepository;

  FavoritesBloc(this.favoritesRepository) : super(FavoritesStateInitial()) {
    
    on<AddToFavorites>((event, emit) async {
      try {
        await favoritesRepository.addToFavorites(event.film);
        emit(FavoritesStateChecked(isFavorite: true));
      } catch (e) {
        emit(FavoritesStateError(message: 'Failed to add to favorites'));
      }
    });

    on<RemoveFromFavorites>((event, emit) async {
      try {
        await favoritesRepository.removeFromFavorites(event.film);
        emit(FavoritesStateChecked(isFavorite: false));
      } catch (e) {
        emit(FavoritesStateError(message: 'Failed to remove from favorites'));
      }
    });

    on<CheckFavoriteStatus>((event, emit) async {
      try {
        final isFavorite = await favoritesRepository.isFavorite(event.film);
        emit(FavoritesStateChecked(isFavorite: isFavorite));
      } catch (e) {
        emit(FavoritesStateError(message: 'Failed to check favorite status'));
      }
    });

    on<LoadFavorites>((event, emit) async {
      try {
        final favorites = await favoritesRepository.getAllFavorites();
        emit(FavoritesStateLoaded(favorites: favorites));
      } catch (e) {
        emit(FavoritesStateError(message: 'Failed to load favorites'));
      }
    });
  }
}