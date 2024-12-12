import 'package:films_app/db/db.dart';
import 'package:films_app/repositories/favorites/favorites.dart';
import 'package:films_app/search_films_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'repositories/search_films/search_films.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DB.instance.init();

  GetIt.I.registerLazySingleton<AbstractFilmsRepository>(() => 
    SearchFilmsRepository(dio: Dio())
  );

  GetIt.I.registerLazySingleton<AbstractFavoritesRepository>(() => 
    FavoritesRepository()
  );
  
  runApp(const SearchFilmsApp());
}


