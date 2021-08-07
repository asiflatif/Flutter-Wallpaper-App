import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:wallpaper/pages/Homepage.dart';
import 'package:wallpaper/pages/collections.dart';
import 'category.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _widgetOptions = <Widget>[HomePage(), Category(), Collections()];

  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.indicator;
  bool showSelectedLabels = true, showUnselectedLabels = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 20),
        snakeViewColor: Theme.of(context).accentColor,
        selectedItemColor: snakeShape == SnakeShape.indicator ? Theme.of(context).accentColor : null,
        unselectedItemColor: Theme.of(context).accentColor.withOpacity(0.5),
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
      body: IndexedStack(
        index: _selectedItemPosition,
        children: _widgetOptions,
      ),
    );
  }
}
