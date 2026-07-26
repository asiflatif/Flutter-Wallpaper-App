import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper/models/photos_model.dart';

/// Pexels API key, supplied at build time so it never lands in version control.
///
/// Grab a free key from https://www.pexels.com/api/ and run the app with:
///   flutter run --dart-define=PEXELS_API_KEY=your_key_here
const String apiKey = String.fromEnvironment('PEXELS_API_KEY');

Future<PhotosModel> getRandomWallpaper(
  String perPage,
  String keywords,
  String pageNo,
) async {
  if (apiKey.isEmpty) {
    throw Exception(
      'Missing Pexels API key. Run with '
      '--dart-define=PEXELS_API_KEY=your_key_here',
    );
  }

  final params = <String, String>{
    'per_page': perPage,
    'query': keywords,
    'page': pageNo,
  };

  final response = await http.get(
    Uri.https('api.pexels.com', 'v1/search', params),
    headers: {'Authorization': apiKey},
  );

  if (response.statusCode == 200) {
    return PhotosModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to load data.');
  }
}
