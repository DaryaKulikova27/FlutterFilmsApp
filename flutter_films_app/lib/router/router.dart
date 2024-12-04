import 'package:crypto_coins_list/features/crypto_list/crypto_list.dart';
import 'package:crypto_coins_list/features/search_films/view/search_films_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/crypto_coin/crypto_coin.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SearchFilmsScreen(title: "Search films"),
      routes: <RouteBase>[
        GoRoute(
          path: '/coins',
          builder: (BuildContext context, GoRouterState state) {
            final coinName = state.extra as String;
            return CryptoCoinScreen(coinName: coinName);
          },
        ),
      ],
      
    ),
  ],
);