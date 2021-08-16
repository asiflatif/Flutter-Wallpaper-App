import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
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

  static final darkTheme = ThemeData(
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    cardColor: Colors.grey[800],
    accentColor: Colors.white,
    bottomAppBarColor: Colors.blueGrey[100],
    highlightColor: Colors.orangeAccent,
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    cardColor: Colors.blueGrey[100],
    accentColor: Colors.blueGrey[800],
    bottomAppBarColor: Colors.blueGrey[800],
    highlightColor: Colors.deepOrange,
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}