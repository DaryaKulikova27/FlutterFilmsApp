import 'package:films_app/features/search_films/bloc/search_films_bloc.dart';
import 'package:films_app/features/search_films/widgets/film_tile.dart';
import 'package:films_app/repositories/search_films/search_films.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SearchFilmsScreen extends StatefulWidget {
  const SearchFilmsScreen({super.key, required this.title});
  final String title;

  @override
  State<SearchFilmsScreen> createState() => _SearchFilmsScreenState();
}

class _SearchFilmsScreenState extends State<SearchFilmsScreen> {
  final _searchFilmsBloc = SearchFilmsBloc(GetIt.I<AbstractFilmsRepository>());
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTextEntered = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateTextState);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_searchFilmsBloc.isFetching) {
        _searchFilmsBloc.add(LoadMoreFilms(filmName: _textController.text));
      }
    });
  }

  void _updateTextState() {
    setState(() {
      _isTextEntered = _textController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            TextField(
              controller: _textController,
              style: theme.textTheme.titleMedium,
              decoration: InputDecoration(
                hintText: 'Поиск...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (_isTextEntered) {
                      _searchFilmsBloc.add(LoadFilmsList(filmName: _textController.text));
                    }
                  },
                  child: Icon(
                    Icons.send,
                    color: _isTextEntered ? Colors.black : Colors.grey,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            BlocBuilder<SearchFilmsBloc, SearchFilmsState>(
              bloc: _searchFilmsBloc,
              builder: (context, state) {
                if (state is SearchFilmsStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SearchFilmsStateLoaded) {
                  return Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: state.films.length + (state.isLoadingMore ? 1 : 0),
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        if (index == state.films.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final film = state.films[index];
                        return FilmTile(film: film);
                      },
                    ),
                  );
                }

                if (state is SearchFilmsStateLoadingFailure) {
                  return Center(child: Text('Ошибка: ${state.exception}'));
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/favorites');
        },
        child: const Icon(Icons.favorite_sharp),
      ),
    );
  }
}