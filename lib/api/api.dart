import 'dart:convert';

import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/utils/constants_ignore.dart';
import 'package:http/http.dart' as http;

Future<PhotosModel> getRandomWallpaper(String per_page, String keywords, String page_no) async {
  Map<String, String> params = {'per_page': per_page, 'query': keywords, 'page': page_no};

  /*
  * apiKEY : Follow the documentation to collect the api Key from https://www.pexels.com/api/
  * */

  final response =
      await http.get(Uri.https('api.pexels.com', 'v1/search', params), headers: {"Authorization": apiKEY});

  if (response.statusCode == 200) {

    return PhotosModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data.');
  }
}
