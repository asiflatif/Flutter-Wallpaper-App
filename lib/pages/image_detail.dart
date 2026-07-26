import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper/utils/responsive.dart';

class ImageDetail extends StatefulWidget {
  const ImageDetail({
    super.key,
    required this.image,
    required this.photographer,
    required this.photographerUrl,
  });

  final String image, photographer, photographerUrl;

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  bool _busy = false;

  Future<void> _setWallpaper(WallpaperTarget target) async {
    if (_busy) return;
    setState(() => _busy = true);
    Fluttertoast.showToast(msg: 'Setting wallpaper…');

    String message;
    try {
      final file = await DefaultCacheManager().getSingleFile(widget.image);
      final result = await AsyncWallpaper.setWallpaper(
        WallpaperRequest(
          target: target,
          sourceType: WallpaperSourceType.file,
          source: file.path,
        ),
      );
      message = result.isSuccess
          ? 'Wallpaper set'
          : result.error?.message ?? 'Failed to set wallpaper.';
    } catch (e) {
      message = 'Failed to set wallpaper.';
    }

    if (!mounted) return;
    setState(() => _busy = false);
    Fluttertoast.showToast(msg: message);
  }

  Future<void> _download() async {
    if (_busy) return;
    setState(() => _busy = true);

    String message;
    try {
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }
      final file = await DefaultCacheManager().getSingleFile(widget.image);
      await Gal.putImage(file.path, album: 'Pexelify');
      message = 'Image saved to your gallery';
    } on GalException catch (e) {
      message = e.type.message;
    } catch (e) {
      message = 'Download failed.';
    }

    if (!mounted) return;
    setState(() => _busy = false);
    Fluttertoast.showToast(msg: message);
  }

  Future<void> _openPhotographerPage() async {
    final url = Uri.tryParse(widget.photographerUrl);
    if (url == null) return;
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.image,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: widget.image,
                placeholder: (context, url) => const ColoredBox(
                  color: Color(0xfff5f8fd),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 5,
              top: Responsive.isMobile(context) ? 60 : 85,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xff1C1B1B).withValues(alpha: 0.7),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By\n',
                          style: captionStyle?.apply(color: Colors.white),
                        ),
                        TextSpan(
                          text: widget.photographer,
                          style: captionStyle?.apply(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _openPhotographerPage,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xff1C1B1B).withValues(alpha: 0.7),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _action(
                    icon: Icons.download_rounded,
                    label: 'Download',
                    onPressed: _download,
                  ),
                  _action(
                    icon: Icons.favorite_border,
                    label: 'Favorite',
                    onPressed: () {},
                  ),
                  _action(
                    icon: Icons.wallpaper,
                    label: 'Set Wallpaper',
                    onPressed: _setWallpaperDialog,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _action({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(icon, size: 40, color: Colors.white),
            onPressed: _busy ? null : onPressed,
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.apply(color: Colors.white),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  void _setWallpaperDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Set wallpaper',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Home Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(Icons.home, color: Colors.black),
                onTap: () {
                  Navigator.pop(dialogContext);
                  _setWallpaper(WallpaperTarget.home);
                },
              ),
              ListTile(
                title: const Text(
                  'Lock Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(Icons.lock, color: Colors.black),
                onTap: () {
                  Navigator.pop(dialogContext);
                  _setWallpaper(WallpaperTarget.lock);
                },
              ),
              ListTile(
                title: const Text(
                  'Both',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(Icons.phone_android, color: Colors.black),
                onTap: () {
                  Navigator.pop(dialogContext);
                  _setWallpaper(WallpaperTarget.both);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
