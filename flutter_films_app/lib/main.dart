import 'package:crypto_coins_list/crypto_currencies_list_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'repositories/crypto_coins/crypto_coins.dart';
import 'repositories/search_films/search_films.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(() => 
    CryptoCoinsRepository(dio: Dio())
  );

  GetIt.I.registerLazySingleton<AbstractFilmsRepository>(() => 
    SearchFilmsRepository(dio: Dio())
  );
  
  runApp(const SearchFilmsApp());
}


