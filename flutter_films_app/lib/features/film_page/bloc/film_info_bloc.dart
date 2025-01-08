import 'package:equatable/equatable.dart';
import 'package:films_app/repositories/film_info/abstract_film_info_repository.dart';
import 'package:films_app/repositories/film_info/models/film_info_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'film_info_event.dart';
part 'film_info_state.dart';

class FilmInfoBloc extends Bloc<FilmInfoEvent, FilmInfoState> {
  FilmInfoBloc(this.filmInfoRepository) : super(FilmInfoInitial()) {
    on<SearchFilmById>(_onSearchFilmById);
  }

  final AbstractFilmInfoRepository filmInfoRepository;

  Future<void> _onSearchFilmById(SearchFilmById event, Emitter<FilmInfoState> emit) async {
    try {
      emit(FilmInfoStateLoading());
      final film = await filmInfoRepository.getFilmById(event.id);
      emit(FilmInfoStateLoaded(film: film));
    } catch (e) {
      emit(FilmInfoStateLoadingFailure(exception: e));
    } 
  }
}