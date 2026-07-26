import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper/api/api.dart';
import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/utils/responsive.dart';
import 'package:wallpaper/widgets/image_card.dart';

class SearchPage extends StatefulWidget {
  final String keyword;

  const SearchPage({super.key, required this.keyword});

  @override
  State<SearchPage> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchPage> {
  late final ScrollController _scrollController;
  final List<Photos> myPhotos = <Photos>[];
  int page = 1;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    fetchPhotos();
    super.initState();
  }

  Future<void> fetchPhotos() async {
    try {
      final response =
          await getRandomWallpaper("8", widget.keyword, page.toString());
      if (!mounted) return;
      if (response.photos.isEmpty) {
        Fluttertoast.showToast(msg: "Search Keyword not valid");
      }
      setState(() {
        myPhotos.addAll(response.photos);
      });
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(msg: "Could not load wallpapers");
    }
  }

  void _scrollListener() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: theme.cardColor.withValues(alpha: 0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            widget.keyword,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MasonryGridView.count(
          controller: _scrollController,
          primary: false,
          crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
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
