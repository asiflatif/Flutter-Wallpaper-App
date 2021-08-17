import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/pages/home.dart';
import 'package:wallpaper/provider/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          routes: {
            '/': (context) => Home(),
          },
          initialRoute: '/',
        );
      },
    );
  }
}
