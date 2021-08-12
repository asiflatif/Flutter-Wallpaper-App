import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/models/category_model.dart';
import 'package:wallpaper/pages/search_view.dart';
import 'package:wallpaper/utils/constants.dart';
import 'package:wallpaper/utils/responsive.dart';

class Category extends StatefulWidget {
  const Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  List<CategoryModel> category = new List();

  @override
  void initState() {
    category = categories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(

      body: SafeArea(
        bottom: false,
        child: GridView.builder(
          padding: EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isMobile(context) ? 1 : 2 ,
                childAspectRatio: Responsive.isMobile(context) ? 2.5 : 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemCount: category.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchPage(
                            keyword: category[index].label,
                          )));
                },
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              category[index].imageUrl
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey.withOpacity(0.5)
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            category[index].label,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.bold,),
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
