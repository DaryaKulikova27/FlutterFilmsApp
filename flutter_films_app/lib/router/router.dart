import 'package:crypto_coins_list/repositories/search_films/models/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/film_page/film_page.dart';
import '../features/search_films/search_films.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SearchFilmsScreen(title: "Search films"),
      routes: <RouteBase>[
        GoRoute(
          path: '/film',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final film = state.extra as Film;
            return CustomTransitionPage(
              child: FilmPageScreen(film: film),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero, 
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return child; 
              },
            );
          },
        ),
      ],
    ),
  ],
);