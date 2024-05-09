import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(208, 188, 213, 1),
      appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(164, 153, 179, 1),
          iconTheme: IconThemeData(color: Color.fromRGBO(27, 23, 37, 1))),
      fontFamily: 'Montserrat',
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(24, 24, 32, 1),
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(31, 46, 69, 1),
          iconTheme: IconThemeData(color: Colors.amber)
        ),
        fontFamily: 'Montserrat',
        );
  }
}
