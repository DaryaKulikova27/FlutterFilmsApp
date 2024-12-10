import 'package:crypto_coins_list/repositories/search_films/search_films.dart';
import 'package:flutter/material.dart';

class FilmPageScreen extends StatefulWidget {
  final Film film;
  const FilmPageScreen({required this.film, super.key});

  @override
  State<StatefulWidget> createState() => _FilmPageScreen();
}

class _FilmPageScreen extends State<FilmPageScreen> {
  late Film? film;

  @override
  void initState() {
    film = widget.film;
    super.initState();
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
        title: Text(film!.name),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  film!.posterUrl,
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
                    onPressed: () {}, 
                    child: const Row(
                      children: [
                        Icon(Icons.play_arrow),
                        Text('Смотреть')
                      ],
                    )
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () {}, 
                    child: const Row(
                      children: [
                        Icon(Icons.favorite),
                      ],
                    )
                  )
                ],
              ),
              const SizedBox(height: 16
              ),

              Text(
                film!.description,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),

              Text(
                'Жанр: ${film!.genres.join(", ")}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),

              Text(
                'Страны: ${film!.countries.join(", ")}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),

              Text(
                'Год: ${film!.year}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),

              Text(
                'Возрастная категория: ${film!.ageRating}+',
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