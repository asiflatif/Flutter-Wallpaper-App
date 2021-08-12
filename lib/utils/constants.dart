import 'dart:typed_data';

import 'package:wallpaper/models/category_model.dart';

var category = [
  "Nature",
  "Beach",
  "Dark",
  "Black",
  "Beautiful",
  "Fish",
  "City",
  "Landscape",
  "Car",
  "Movie",
  "Models",
  "Actors"
];

List<CategoryModel> categories() {
  List<CategoryModel> myCategories = new List();

  myCategories.add(CategoryModel(category[0],
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[1],
      "https://images.pexels.com/photos/1680140/pexels-photo-1680140.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[2],
      "https://images.pexels.com/photos/2449600/pexels-photo-2449600.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[3],
      "https://images.pexels.com/photos/695644/pexels-photo-695644.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[4],
      "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[5],
      "https://images.pexels.com/photos/2156311/pexels-photo-2156311.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[6],
      "https://images.pexels.com/photos/2129796/pexels-photo-2129796.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[7],
      "https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[8],
      "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[9],
      "https://images.pexels.com/photos/4473634/pexels-photo-4473634.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[10],
      "https://images.pexels.com/photos/160590/girls-beauty-makeup-dark-160590.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));
  myCategories.add(CategoryModel(category[11],
      "https://images.pexels.com/photos/53370/cary-grant-rosalind-russell-ralph-bellamy-actor-53370.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200"));

  return myCategories;
}

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);
