import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Montserrat',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      // inverseSurface drives the bottom navigation bar, which is deliberately
      // inverted against the scaffold so it reads as a floating element.
      inverseSurface: Colors.blueGrey.shade100,
      onInverseSurface: Colors.black,
    ),
    cardColor: Colors.grey[800],
    highlightColor: Colors.orangeAccent,
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      inverseSurface: Colors.blueGrey.shade800,
      onInverseSurface: Colors.white,
    ),
    cardColor: Colors.blueGrey[100],
    highlightColor: Colors.deepOrange,
    iconTheme: const IconThemeData(color: Colors.red, opacity: 0.8),
  );
}
