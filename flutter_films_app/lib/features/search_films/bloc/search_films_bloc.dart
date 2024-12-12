import 'package:films_app/repositories/search_films/search_films.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_films_event.dart';
part 'search_films_state.dart';

class SearchFilmsBloc extends Bloc<SearchFilmsEvent, SearchFilmsState> {
  SearchFilmsBloc(this.searchFilmsRepository) : super(SearchFilmsStateInitial()) {
    on<LoadFilmsList>((event, emit) async {
        try {
					if (state is! SearchFilmsStateLoaded) {
						emit(SearchFilmsStateLoading());
					} 
					final films = await searchFilmsRepository.searchFilms(event.filmName);
					emit(SearchFilmsStateLoaded(films: films));
        } catch(e) {
            emit(SearchFilmsStateLoadingFailure(exception: e));
        } 
    });
  }

  final AbstractFilmsRepository searchFilmsRepository;
}