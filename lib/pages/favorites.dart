import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:wallpaper/api/api.dart';
import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/utils/responsive.dart';
import 'package:wallpaper/widgets/changeThemeButtonWidget.dart';
import 'package:wallpaper/widgets/image_card.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _CollectionsState();
}

class _CollectionsState extends State<Favorites> {
  int page = 1;
  String category = "nature";
  final List<Photos> myPhotos = <Photos>[];

  Future<void> fetchPhotos() async {
    try {
      final response = await getRandomWallpaper("6", category, page.toString());
      if (!mounted) return;
      setState(() {
        myPhotos.addAll(response.photos);
      });
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: "Could not load wallpapers");
    }
  }

  @override
  void initState() {
    fetchPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 65,
              backgroundColor: theme.cardColor.withValues(alpha: 0.8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
              title: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/3536991/pexels-photo-3536991.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const Text("Username")
                ],
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const ChangeThemeButtonWidget(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: CircleAvatar(
                    backgroundColor: theme.highlightColor,
                    child: IconButton(
                      icon: const Icon(
                        Icons.logout,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MasonryGridView.count(
                primary: false,
                crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                itemCount: myPhotos.length,
                itemBuilder: (context, index) {
                  final photo = myPhotos[index];
                  return ImageCard(
                    imageDetail: (Responsive.isMobile(context)
                            ? photo.src?.large2x
                            : photo.src?.landscape) ??
                        '',
                    imageUrl: photo.src?.medium ?? '',
                    photographer: photo.photographer ?? 'Unknown',
                    color: photo.avgColor ?? '#9E9E9E',
                    photographerUrl: photo.photographerUrl ?? '',
                  );
                },
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200.withValues(alpha: 0.7),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Please Sign up to create favorite collection",
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                getMobileFormWidget(context),
                const SizedBox(height: 15),
                const Row(
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
          ),
        ],
      ),
    );
  }

  Widget getMobileFormWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SignInButton(
          Buttons.google,
          text: "Sign in with Google",
          padding: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
          onPressed: () {},
        ),
      ],
    );
  }
}
