import 'package:cached_network_image/cached_network_image.dart';
import 'package:films_app/features/favorites_page/bloc/favorites_bloc.dart';
import 'package:films_app/features/film_page/bloc/film_info_bloc.dart';
import 'package:films_app/repositories/favorites/favorites.dart';
import 'package:films_app/repositories/film_info/film_info.dart';
import 'package:films_app/repositories/search_films/search_films.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FilmPageScreen extends StatefulWidget {
  final Film film;
  const FilmPageScreen({required this.film, super.key});

  @override
  State<StatefulWidget> createState() => _FilmPageScreen();
}

class _FilmPageScreen extends State<FilmPageScreen> {
  late Film film;
  late FilmInfoModel filmInfo;
  final _favoritesBloc = FavoritesBloc(GetIt.I<AbstractFavoritesRepository>());
  final _filmInfoBloc = FilmInfoBloc(GetIt.I<AbstractFilmInfoRepository>());
  String? trailerUrl;

  @override
  void initState() {
    super.initState();
    film = widget.film;
    _filmInfoBloc.add(SearchFilmById(id: film.id));
    _favoritesBloc.add(CheckFavoriteStatus(film: film));
  }

  @override
  void dispose() {
    _filmInfoBloc.close();
    _favoritesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(film.name),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<FilmInfoBloc, FilmInfoState>(
          bloc: _filmInfoBloc,
          builder: (context, state) {
            if (state is FilmInfoStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FilmInfoStateLoaded) {
              filmInfo = state.film;
              trailerUrl = state.film.trailers.firstOrNull?.url;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: film.posterUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: film.posterUrl,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/png/no_image.png',
                                fit: BoxFit.cover,
                              ),
                              height: 300,
                              width: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/png/no_image.png',
                              height: 300,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: trailerUrl != null
                              ? () {
                                  _showTrailerDialog(context, trailerUrl!);
                                }
                              : null,
                          child: const Row(
                            children: [
                              Icon(Icons.play_arrow),
                              Text('Смотреть'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        BlocBuilder<FavoritesBloc, FavoritesState>(
                          bloc: _favoritesBloc,
                          builder: (context, state) {
                            final isFavorite =
                                state is FavoritesStateChecked && state.isFavorite;
                            return TextButton(
                              onPressed: () {
                                if (isFavorite) {
                                  _favoritesBloc.add(RemoveFromFavorites(film: film));
                                } else {
                                  _favoritesBloc.add(AddToFavorites(film: film));
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      film.description,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Жанр: ${film.genres.join(", ")}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),

                    Text(
                      'Страны: ${film.countries.join(", ")}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),

                    Text(
                      'Год: ${film.year}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),

                    Text(
                      'Возрастная категория: ${film.ageRating}+',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              );
            } else if (state is FilmInfoStateLoadingFailure) {
              return Center(
                child: Text(
                  'Ошибка загрузки информации о фильме.',
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _showTrailerDialog(BuildContext context, String trailerUrl) {
    final videoId = YoutubePlayer.convertUrlToId(trailerUrl);

    if (videoId == null) {
      _showErrorDialog(context, 'Видео недоступно. Проверьте ссылку.');
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Center(
              child: Dialog(
                insetPadding: const EdgeInsets.all(16),
                backgroundColor: Colors.transparent,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: videoId,
                      flags: const YoutubePlayerFlags(
                        autoPlay: true,
                        mute: false,
                        hideThumbnail: true,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ошибка'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ок'),
            ),
          ],
        );
      },
    );
  }
}