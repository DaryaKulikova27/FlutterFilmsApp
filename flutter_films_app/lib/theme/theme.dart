import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
  useMaterial3: true,
  dividerColor: Colors.white24,
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 67, 65, 65),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  primarySwatch: Colors.yellow,
  scaffoldBackgroundColor: const Color.fromARGB(26, 17, 52, 255),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20
    ),
    labelSmall: TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontWeight: FontWeight.w700,
      fontSize: 14
    )
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), 
      ),
      textStyle: const TextStyle(
        fontSize: 18, 
        fontWeight: FontWeight.bold,
      ),
    ),
  )
);