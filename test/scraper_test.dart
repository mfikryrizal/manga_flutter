import 'package:flutter_test/flutter_test.dart';
import 'package:manga_flutter/data/manga_tile_data.dart';
import 'package:manga_flutter/scraper/home_scraper.dart';

void main() async {
  final HomeScraper homeScraper = HomeScraper();
  test('Load Home page without errors', () async {
    final bool result = await homeScraper.loadPage();
    expect(result, true);
  });

  test('Extract MangaTile', () async {
    await homeScraper.loadPage();
    final result = homeScraper.getMangaTiles();
    expect(result is List<MangaTileData>, true);
    expect(result.isNotEmpty, true);
    expect(
        result.any((element) =>
            element.title.isEmpty || element.title.endsWith('null')),
        false);
    expect(
        result.any((element) =>
            element.imgSrc.isEmpty || element.imgSrc.endsWith('null')),
        false);
  });
}
