import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Color.fromRGBO(40, 98, 245, 1),
    fontFamily: 'Arial',
    scaffoldBackgroundColor: Colors.white,

  );
}