import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/utils/constants.dart';
import 'package:wallpaper/utils/responsive.dart';

void main() {
  group('PhotosModel', () {
    test('parses a Pexels search response', () {
      final model = PhotosModel.fromJson(<String, dynamic>{
        'page': 1,
        'per_page': 2,
        'total_results': 8000,
        'photos': [
          {
            'id': 1181562,
            'photographer': 'Christina Morillo',
            'photographer_url': 'https://www.pexels.com/@divinetechygirl',
            'avg_color': '#8B7B6C',
            'src': {'medium': 'https://example.com/m.jpg'},
          },
        ],
      });

      expect(model.page, 1);
      expect(model.totalResults, 8000);
      expect(model.photos, hasLength(1));
      expect(model.photos.first.photographer, 'Christina Morillo');
      expect(model.photos.first.src?.medium, 'https://example.com/m.jpg');
    });

    test('tolerates a response with no photos key', () {
      final model = PhotosModel.fromJson(<String, dynamic>{'page': 3});

      expect(model.photos, isEmpty);
      expect(model.nextPage, isNull);
    });
  });

  test('every category has a preview image', () {
    final all = categories();

    expect(all, hasLength(category.length));
    expect(all.every((c) => c.imageUrl.startsWith('https://')), isTrue);
  });

  Widget responsiveAt(Size size) => MediaQuery(
        data: MediaQueryData(size: size),
        child: const MaterialApp(
          home: Responsive(
            mobile: Text('mobile'),
            tablet: Text('tablet'),
          ),
        ),
      );

  testWidgets('Responsive falls back to the mobile layout below 850px',
      (WidgetTester tester) async {
    await tester.pumpWidget(responsiveAt(const Size(400, 800)));

    expect(find.text('mobile'), findsOneWidget);
    expect(find.text('tablet'), findsNothing);
  });

  testWidgets('Responsive uses the tablet layout at 850px and above',
      (WidgetTester tester) async {
    await tester.pumpWidget(responsiveAt(const Size(1000, 800)));

    expect(find.text('tablet'), findsOneWidget);
    expect(find.text('mobile'), findsNothing);
  });
}
