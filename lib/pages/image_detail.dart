import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper/utils/responsive.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ImageDetail extends StatefulWidget {
  const ImageDetail({Key key, this.image, this.photographer, this.photographerUrl}) : super(key: key);

  final String image, photographer,photographerUrl;

  @override
  _ImageDetailState createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  String _wallpaperFile = 'Unknown';
  bool setWallpaper = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermission();
  }

  Future<void> setWallpaperFromFile(int setFor) async {
    setState(() {
      _wallpaperFile = "Loading";
      setWallpaper = true;
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.image);

    try {
      result = await WallpaperManager.setWallpaperFromFile(file.path, setFor);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;
    setState(() {
      _wallpaperFile = result;
      setWallpaper = false;
    });
    Fluttertoast.showToast(msg: _wallpaperFile);
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [Permission.storage].request();

    final info = statuses[Permission.storage];

    //if user permanently denied permission, open app setting..
    if (info == PermissionStatus.permanentlyDenied) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Text("Open app setting to grant access."),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () async {
                    Navigator.pop(context);
                    openAppSettings();
                  },
                ),
                TextButton(
                  child: Text('Close'),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  _getHttp() async {
    //check storage status
    var status = await Permission.storage.status.isGranted;
    if (status) {
      var response = await Dio().get(widget.image, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      if (result['isSuccess']) {
        Fluttertoast.showToast(msg: "Image Saved in local storage");
      }
    }
    //if permission not granted, check again!!
    if (await Permission.storage.isDenied) {
      _requestPermission();
    }
  }

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
            margin: EdgeInsets.only(left: 5, top: Responsive.isMobile(context) ? 60 : 85),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Spacer(),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Color(0xff1C1B1B).withOpacity(0.7),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20))),
                  child: new RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'By\n',
                          style: Theme.of(context).textTheme.caption.apply(color: Colors.white),
                        ),
                        new TextSpan(
                          text: widget.photographer.toString(),
                          style: Theme.of(context).textTheme.caption.apply(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (await canLaunch(widget.photographerUrl)) {
                                await launch(
                                  widget.photographerUrl,
                                  forceSafariVC: false,
                                );
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xff1C1B1B).withOpacity(0.7),
                borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.download_rounded,
                                size: 40,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _getHttp();
                              }),
                          Text(
                            "Download",
                            style: Theme.of(context).textTheme.caption.apply(color: Colors.white),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                size: 40,
                                color: Colors.white,
                              ),
                              onPressed: () {}),
                          Text(
                            "Favorite",
                            style: Theme.of(context).textTheme.caption.apply(color: Colors.white),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.wallpaper,
                                size: 40,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setWallpaperFromFile(WallpaperManager.HOME_SCREEN);
                              }),
                          Text(
                            "Set as Wallpaper",
                            style: Theme.of(context).textTheme.caption.apply(color: Colors.white),
                            textAlign: TextAlign.center,
                          )
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
