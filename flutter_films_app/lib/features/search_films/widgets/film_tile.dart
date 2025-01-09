import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../repositories/search_films/models/models.dart';

class FilmTile extends StatelessWidget {
  const FilmTile({
    Key? key,
    required this.film
  });

  final Film film;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: film.posterUrl.isNotEmpty
      ? CachedNetworkImage(
          imageUrl: film.posterUrl, 
          placeholder: (context, url) => const CircularProgressIndicator(), 
          errorWidget: (context, url, error) => Image.asset('assets/png/no_image.png', fit: BoxFit.cover)
        )
      : Image.asset(
          'assets/png/no_image.png',
          fit: BoxFit.cover,
        ),
      title: Text(
        film.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        film.shortDescription,
        style: theme.textTheme.labelSmall,
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => {
        context.go('/film', extra: film)
      }
    );
  }
}