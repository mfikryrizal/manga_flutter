import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manga_flutter/components/manga_tile.dart';
import 'package:manga_flutter/data/manga_tile_data.dart';
import 'package:network_image_mock/network_image_mock.dart';

var mockData = MangaTileData(
    'Mock title',
    'https://homepages.cae.wisc.edu/~ece533/images/zelda.png',
    'https://homepages.cae.wisc.edu/~ece533/images/');

Widget makeTestableWidget() => MaterialApp(
    home: Scaffold(
        body: MangaTile(
            title: mockData.title,
            imgSrc: mockData.imgSrc,
            ref: mockData.ref)));

void main() {
  testWidgets('MangaTile has a title and Image widget',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(makeTestableWidget());
      final titleFinder = find.text('Mock title');
      final imageFinder = find.byWidgetPredicate((widget) => widget is Image);
      expect(titleFinder, findsOneWidget);
      expect(imageFinder, findsOneWidget);
    });
  });
  testWidgets(
      'Tapping MangaTitle creates a Snackbar to show manga URL,'
      ' and only can one exist at a tine', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      final snackbarMsg = 'Opening ${mockData.ref}...';
      await tester.pumpWidget(makeTestableWidget());
      final imageFinder = find.text(mockData.title);
      expect(find.text(snackbarMsg), findsNothing);
      await tester.tap(imageFinder);
      await tester.pump();
      expect(find.text(snackbarMsg), findsOneWidget);
      await tester.tap(imageFinder);
      await tester.pump();
      expect(find.text(snackbarMsg), findsOneWidget);
    });
  });
}
