import 'dart:ui';
import 'package:file/memory.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:manga_flutter/data/manga_tile_data.dart';
import 'package:manga_flutter/scraper/home_scraper.dart';
import 'package:mime/mime.dart';

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
    expect(
        result.any(
            (element) => element.ref.isEmpty || element.ref.endsWith('null')),
        false);
  });

  test('Get image for MangaTile', () async {
    await homeScraper.loadPage();
    final results = homeScraper.getMangaTiles();
    var fs = MemoryFileSystem();
    int count = 0;
    for (MangaTileData m in results) {
      var response = await http.get(Uri.parse(m.imgSrc));
      var tf = await fs.file('temp-${count++}.jpg').create();
      await tf.writeAsBytes(response.bodyBytes, flush: true);
      var mime = lookupMimeType(tf.path, headerBytes: [0xFF, 0xD8]);
      expect(mime?.startsWith('image'), true);
      tf.delete();
    }
  });
}
