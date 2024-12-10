import 'package:crypto_coins_list/features/search_films/bloc/search_films_bloc.dart';
import 'package:crypto_coins_list/features/search_films/widgets/film_tile.dart';
import 'package:crypto_coins_list/repositories/search_films/search_films.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchFilmsScreen extends StatefulWidget {
  const SearchFilmsScreen({super.key, required this.title});
  final String title;

  @override
  State<SearchFilmsScreen> createState() => _SearchFilmsScreenState();
}

class _SearchFilmsScreenState extends State<SearchFilmsScreen> {
  final _searchFilmsBloc = SearchFilmsBloc(GetIt.I<AbstractFilmsRepository>());
  final TextEditingController _textController = TextEditingController();
  bool _isTextEntered = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateTextState);
  }

  void _updateTextState() {
    setState(() {
      _isTextEntered = _textController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: 
            Column(
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
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                ),
                BlocBuilder<SearchFilmsBloc, SearchFilmsState>(
                  bloc: _searchFilmsBloc,
                  builder: (context, state) {
                    if (state is SearchFilmsStateLoaded) {
                      return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 16),
                          itemCount: state.films.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, i) {
                            final film = state.films[i];
                            return FilmTile(film: film);
                          },
                        ),
                      );
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
        )
    );
  }
}