import 'package:flutter/material.dart';

const Color _primaryColor = Colors.amberAccent;
const Color _backgroundColor = Color.fromARGB(255, 50, 50, 50);
const Color _cardColor = Color.fromARGB(255, 58, 58, 58);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: _backgroundColor,
  colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor, brightness: Brightness.dark),
  primaryColor: _primaryColor,
  useMaterial3: true,
  listTileTheme: ListTileThemeData(
    iconColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12)
    ),
  ),
  cardTheme: const CardTheme(color: _cardColor),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(_cardColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
  )))),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: _backgroundColor,
    surfaceTintColor: _backgroundColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 20,
  )),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFF2E2E2E),
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.horizontal,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
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
