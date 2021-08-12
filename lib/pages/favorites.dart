import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper/api/api.dart';
import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/utils/responsive.dart';
import 'package:wallpaper/widgets/changeThemeButtonWidget.dart';
import 'package:wallpaper/widgets/image_card.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key key}) : super(key: key);

  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Favorites> {
  int page = 1;
  String category = "nature";
  List<Photos> myPhotos = new List();

  fetchPhotos() async {
    var response = await getRandomWallpaper("6", category, page.toString());
    response.photos.forEach((element) {
      myPhotos.add(element);
    });
    setState(() {});
  }

  @override
  void initState() {
    fetchPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 65,
            backgroundColor: Theme.of(context).cardColor.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            title: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/3536991/pexels-photo-3536991.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text("Username")
              ],
            ),
            actions: [
              Container(
                child: ChangeThemeButtonWidget(),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(50)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: CircleAvatar(
                    backgroundColor: Theme.of(context).highlightColor,
                    child: IconButton(
                        icon: Icon(
                          Icons.logout,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {})),
              ),
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: StaggeredGridView.countBuilder(
              primary: false,
              crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              itemCount: myPhotos.length,
              itemBuilder: (context, index) => ImageCard(
                imageDetail: Responsive.isMobile(context)
                    ? myPhotos[index].src.large2x
                    : myPhotos[index].src.landscape,
                imageUrl: myPhotos[index].src.medium,
                photographer: myPhotos[index].photographer,
                color: myPhotos[index].avgColor,
              ),
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            ),
          ),
        ),
        BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: new Container(
            height: _size.height,
            width: _size.width,
            decoration: new BoxDecoration(color: Colors.grey.shade200.withOpacity(0.7)),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Please Sign up to create favorite collection",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              getMobileFormWidget(context),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.wb_sunny,
                    color: Colors.orangeAccent,
                  ),
                  ChangeThemeButtonWidget(),
                  Icon(
                    Icons.nights_stay,
                    color: Colors.blueGrey,
                  ),
                ],
              )
            ],
          ),

          //
        ),
      ],
    ));
  }

  getMobileFormWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SignInButton(
          Buttons.Google,
          text: "Sign in with Google",
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
          onPressed: () {},
        ),
      ],
    );
  }
}
