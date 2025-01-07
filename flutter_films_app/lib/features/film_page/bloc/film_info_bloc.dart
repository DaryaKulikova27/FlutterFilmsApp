// part 'film_review_event.dart';
// part 'film_review_state.dart';

// class FilmReviewBloc extends Bloc<FilmReviewEvent, FilmReviewState> {
//   FilmReviewBloc() : super(FilmReviewInitial()) {
//     on<SearchFilmByIDEvent>((event, emit) async {
//       if (event.film == null) {
//         var response = await getFilmsByID(event.id);
//         if (response != null) {
//           var review = FilmReviewModel.fromJSON(response);
//           emit(SearchSuccess(review: review));
//         } else {
//           emit(SearchFailed());
//         }
//       } else {
//         emit(SearchSuccess(review: event.film!));
//       }
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

class FilmInfoBloc extends Bloc<FilmInfoEvent, FilmInfoState> {
  FilmInfoBloc(this.filmInfoRepository) : super(FilmInfoInitial()) {
    on<SearchFilmById>(_onSearchFilmById);
  }

  final AbstractFilmInfoRepository filmInfoRepository;

  Future<void> _onSearchFilmById(LoadFilmsList event, Emitter<SearchFilmsState> emit) async {
    try {
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