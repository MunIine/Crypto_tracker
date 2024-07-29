import 'package:flutter/material.dart';

const Color primaryColor = Colors.amberAccent;
const Color backgroundColor = Color.fromARGB(255, 50, 50, 50);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: backgroundColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.dark),
  primaryColor: primaryColor,
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
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
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
