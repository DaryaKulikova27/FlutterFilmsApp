import 'package:films_app/features/favorites_page/bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../repositories/favorites/favorites.dart';
import '../../search_films/widgets/film_tile.dart';

class FavoritesPageScreen extends StatefulWidget {
  const FavoritesPageScreen({super.key});

  @override
  State<FavoritesPageScreen> createState() => _FavoritesPageScreenState();
}

class _FavoritesPageScreenState extends State<FavoritesPageScreen> {
  final _favoritesBloc = FavoritesBloc(GetIt.I<AbstractFavoritesRepository>());

  @override
  void initState() {
    super.initState();
    _favoritesBloc.add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Избранное"),
        automaticallyImplyLeading: true,
      ),
      body: 
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<FavoritesBloc, FavoritesState>(
                  bloc: _favoritesBloc,
                  builder: (context, state) {
                    if (state is FavoritesStateLoaded) {
                      return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 16),
                          itemCount: state.favorites.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, i) {
                            final film = state.favorites[i];
                            return FilmTile(film: film);
                          },
                        ),
                      );
                    }
                    if (state is FavoritesStateError) {
                      return Text(state.message);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        Image.asset(
                          'assets/png/empty_films_list.png',
                          width: 200,
                          height: 300,
                        ),
                      ],
                    );
                  },
                ),
              ]
            )
        ),
    );
  }
}