import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper/api/api.dart';
import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/pages/search_view.dart';
import 'package:wallpaper/utils/responsive.dart';
import 'package:wallpaper/widgets/image_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  int page = 1;

  bool closeSearch = true;
  String category = "nature";
  final TextEditingController searchController = TextEditingController();
  final List<Photos> myPhotos = <Photos>[];

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    fetchPhotos();
    super.initState();
  }

  Future<void> fetchPhotos() async {
    try {
      final response = await getRandomWallpaper("5", category, page.toString());
      if (!mounted) return;
      setState(() {
        myPhotos.addAll(response.photos);
      });
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: "Could not load wallpapers");
    }
  }

  void _scrollListener() {
    setState(() {
      closeSearch = true;
    });
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      page++;
      fetchPhotos();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Pexelify',
                  style: theme.textTheme.titleLarge,
                ),
                TextSpan(
                  text: ' .photos by pexels.com',
                  style: theme.textTheme.bodySmall?.apply(
                    color: Colors.blueGrey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          AnimatedCrossFade(
            firstChild: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                padding: const EdgeInsets.only(right: 30),
                icon: const Icon(Icons.search, size: 30),
                onPressed: () {
                  setState(() {
                    closeSearch = false;
                  });
                },
              ),
            ),
            secondChild: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (String value) {
                        if (value.trim().isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Search field cannot be empty");
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(
                                keyword: searchController.text,
                              ),
                            ),
                          );
                        }
                      },
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "search wallpapers",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: closeSearch
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 400),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MasonryGridView.count(
          controller: _scrollController,
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
    );
  }
}
