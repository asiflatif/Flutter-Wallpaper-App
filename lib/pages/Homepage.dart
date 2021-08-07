import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper/utils/constants.dart';
import 'package:wallpaper/utils/responsive.dart';

class HomePage extends StatefulWidget {
  static const int _kItemCount = 20;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  List<int> items = [];
  Random random = new Random();

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    for (int i = 0; i < 20; i++)
      items.add(random.nextInt(200));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _getMoreData();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaggeredGridView.countBuilder(
        controller: _scrollController,
        primary: false,
        crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: items.length,
        itemBuilder: (context, index) =>
            Card(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      //Center(child: CircularProgressIndicator()),
                      Center(
                        child: FadeInImage.memoryNetwork(
                          imageScale: 0.5,
                          placeholder: kTransparentImage,
                          // image: 'https://source.unsplash.com/random?sig='+random.nextInt(200).toString(),
                          image: 'https://source.unsplash.com/featured/?' + items[index].toString(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      ),
    );
  }

  void _getMoreData() {
    print(items.length);

    for (var i = 0; i < 10; i++) {
      items.add(random.nextInt(200));
    }
  }
}
