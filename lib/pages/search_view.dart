import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper/api/api.dart';
import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/utils/constants.dart';
import 'package:wallpaper/utils/responsive.dart';
import 'package:wallpaper/widgets/image_card.dart';

class SearchPage extends StatefulWidget {
  final String keyword;

  const SearchPage({Key key, this.keyword}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchPage> {
  ScrollController _scrollController;
  List<Photos> myPhotos = new List();
  int page = 1;

  @override
  void initState() {
    _scrollController = new ScrollController(initialScrollOffset: 5.0)..addListener(_scrollListener);
    fetchPhotos();
    super.initState();
  }

  fetchPhotos() async {
    var response = await getRandomWallpaper("8", widget.keyword, page.toString());
    response.photos.length != 0
        ? response.photos.forEach((element) {
            myPhotos.add(element);
          })
        : Fluttertoast.showToast(msg: "Search Keyword not valid");

    setState(() {});
  }

  _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      page++;
      print("page:" + page.toString());
      fetchPhotos();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            widget.keyword,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          primary: false,
          crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: myPhotos.length,
          itemBuilder: (context, index) {
            return ImageCard(
              imageDetail:
                  Responsive.isMobile(context) ? myPhotos[index].src.large2x : myPhotos[index].src.landscape,
              imageUrl: myPhotos[index].src.medium,
              photographer: myPhotos[index].photographer,
              color: myPhotos[index].avgColor,
            );
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        ),
      ),
    );
  }
}
