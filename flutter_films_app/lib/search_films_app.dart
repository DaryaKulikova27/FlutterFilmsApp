import 'package:films_app/router/router.dart';
import 'package:films_app/theme/theme.dart';
import 'package:flutter/material.dart';

class SearchFilmsApp extends StatelessWidget {
  const SearchFilmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: darkTheme,
      routerConfig: router
    );
  }
}