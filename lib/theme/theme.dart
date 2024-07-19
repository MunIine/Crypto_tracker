import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
  useMaterial3: true,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  cardTheme: const CardTheme(color: Color.fromARGB(255, 58, 58, 58)),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 58, 58, 58)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
  )))),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 50, 50, 50),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 20,
  )),
  textTheme: TextTheme(
    bodyLarge: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 26,
    ),
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    labelMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
    headlineMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 24,
    ),
  ),
);
