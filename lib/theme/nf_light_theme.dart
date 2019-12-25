import 'package:flutter/material.dart';

final ThemeData nfLightTheme = ThemeData(
  /* Basic Colors */
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
  primaryColor: Colors.amber,
  primaryColorBrightness: Brightness.light,
  primaryColorLight: Colors.amber[50],
  primaryColorDark: Colors.amber[800],
  accentColor: Colors.blue[800],
  accentColorBrightness: Brightness.light,

  /* Scaffold */
  scaffoldBackgroundColor: Colors.grey[50],
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.grey[50],
  ),
  bottomAppBarColor: Colors.grey[50],

  /* Components */
  cursorColor: Colors.amber,
  textSelectionColor: Colors.amber[200],  
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[50],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[50],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.amber,
        width: 2,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[50],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);