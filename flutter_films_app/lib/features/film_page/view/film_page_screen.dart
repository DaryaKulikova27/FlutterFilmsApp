import 'package:films_app/features/favorites_page/bloc/favorites_bloc.dart';
import 'package:films_app/repositories/favorites/favorites.dart';
import 'package:films_app/repositories/search_films/search_films.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FilmPageScreen extends StatefulWidget {
  final Film film;
  const FilmPageScreen({required this.film, super.key});

  @override
  State<StatefulWidget> createState() => _FilmPageScreen();
}

class _FilmPageScreen extends State<FilmPageScreen> {
  late Film film;
  final _favoritesBloc = FavoritesBloc(GetIt.I<AbstractFavoritesRepository>());

  @override
  void initState() {
    super.initState();
    film = widget.film;
    _favoritesBloc.add(CheckFavoriteStatus(film: film));
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: 
                  film.posterUrl.isNotEmpty
                  ? Image.network(
                    film.posterUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/png/no_image.png',
                        fit: BoxFit.cover,
                      );
                    },
                    height: 300,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                  : Image.asset(
                    'assets/png/no_image.png',
                    height: 300,
                    width: 200,
                    fit: BoxFit.cover,
                  )
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {}, 
                    child: const Row(
                      children: [
                        Icon(Icons.play_arrow),
                        Text('Смотреть')
                      ],
                    )
                  ),
                  const SizedBox(width: 16),
                  BlocBuilder<FavoritesBloc, FavoritesState>(
                    bloc: _favoritesBloc,
                    builder: (context, state) {
                      final isFavorite = state is FavoritesStateChecked && state.isFavorite;
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
                        )
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
        ),
      ),
    );
  }
}