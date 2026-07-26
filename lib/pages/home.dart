import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:wallpaper/pages/favorites.dart';
import 'package:wallpaper/pages/homepage.dart';

import 'category.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _widgetOptions = const <Widget>[
    HomePage(),
    Category(),
    Favorites(),
  ];

  final ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  final SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  final SnakeShape snakeShape = SnakeShape.indicator;
  int _selectedItemPosition = 0;
  bool showSelectedLabels = true, showUnselectedLabels = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: theme.colorScheme.inverseSurface,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2,
          vertical: 20,
        ),
        snakeViewColor: theme.highlightColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? theme.cardColor : null,
        unselectedItemColor: theme.cardColor.withValues(alpha: 0.5),
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 8),
      ),
      body: IndexedStack(
        index: _selectedItemPosition,
        children: _widgetOptions,
      ),
    );
  }
}
