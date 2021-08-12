import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/utils/responsive.dart';

class ImageDetail extends StatefulWidget {
  const ImageDetail({Key key, this.image, this.photographer}) : super(key: key);

  final String image,photographer;

  @override
  _ImageDetailState createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.image,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                  imageUrl: widget.image,
                  placeholder: (context, url) => Container(
                    color: Color(0xfff5f8fd),
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5,top: Responsive.isMobile(context) ? 60 : 85),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Spacer(),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 5,top: 5,bottom: 5),
                  decoration: BoxDecoration(
                      color: Color(0xff1C1B1B).withOpacity(0.7),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20))),
                  child: Text(
                    "By \n" + widget.photographer.toString(),
                    style: Theme.of(context).textTheme.caption.apply(color: Colors.white),
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height*0.12,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xff1C1B1B).withOpacity(0.7),
                borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
              ),
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(icon: Icon(Icons.download_rounded,size: 40,color: Colors.white,), onPressed: (){}),
                          Text("Download",style: Theme.of(context).textTheme.caption.apply(color: Colors.white),textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(icon: Icon(Icons.favorite_border,size: 40,color: Colors.white,), onPressed: (){}),
                          Text("Favorite",style: Theme.of(context).textTheme.caption.apply(color: Colors.white),textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(icon: Icon(Icons.wallpaper,size: 40,color: Colors.white,), onPressed: (){}),
                          Text("Set as Wallpaper",style: Theme.of(context).textTheme.caption.apply(color: Colors.white),textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
