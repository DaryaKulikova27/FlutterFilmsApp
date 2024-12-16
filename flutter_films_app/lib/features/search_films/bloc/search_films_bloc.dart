import 'package:films_app/repositories/search_films/search_films.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_films_event.dart';
part 'search_films_state.dart';

class SearchFilmsBloc extends Bloc<SearchFilmsEvent, SearchFilmsState> {
  SearchFilmsBloc(this.searchFilmsRepository) : super(SearchFilmsStateInitial()) {
    on<LoadFilmsList>(_onLoadFilmsList);
    on<LoadMoreFilms>(_onLoadMoreFilms);
  }

  final AbstractFilmsRepository searchFilmsRepository;
  bool isFetching = false; 

  int _currentPage = 1;
  bool _hasMore = true; 
  final filmsNumberOnPage = 6;
  List<Film> _allFilms = [];

  Future<void> _onLoadFilmsList(LoadFilmsList event, Emitter<SearchFilmsState> emit) async {
    try {
      isFetching = true;
      _currentPage = 1;
      _hasMore = true;
      _allFilms.clear(); 
      emit(SearchFilmsStateLoading());

      final films = await searchFilmsRepository.searchFilms(event.filmName, _currentPage);
      _allFilms.addAll(films);

      _hasMore = films.length == filmsNumberOnPage; 
      emit(SearchFilmsStateLoaded(films: _allFilms, hasMore: _hasMore, isLoadingMore: false));
    } catch (e) {
      emit(SearchFilmsStateLoadingFailure(exception: e));
    } finally {
      isFetching = false;
    }
  }
  
  Future<void> _onLoadMoreFilms(LoadMoreFilms event, Emitter<SearchFilmsState> emit) async {
    if (!_hasMore || isFetching) return;

    try {
      isFetching = true;
      emit(SearchFilmsStateLoaded(films: _allFilms, hasMore: _hasMore, isLoadingMore: true));

      _currentPage++;
      final films = await searchFilmsRepository.searchFilms(event.filmName, _currentPage);
      _allFilms.addAll(films);

      _hasMore = films.length == filmsNumberOnPage;
      emit(SearchFilmsStateLoaded(films: _allFilms, hasMore: _hasMore, isLoadingMore: false));
    } catch (e) {
      emit(SearchFilmsStateLoadingFailure(exception: e));
    } finally {
      isFetching = false;
    }
  }
}