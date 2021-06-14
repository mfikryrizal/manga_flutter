import 'package:manga_flutter/middleware/manga_adapter/manga_scraper.dart';
import 'package:manga_flutter/model/manga_preview.dart';
import 'package:manga_flutter/model/manga.dart';
import 'package:manga_flutter/model/chapter.dart';

class ManganeloScraper extends BaseMangaScraper {
  @override
  final String baseUrl =
      'https://scraper-private.herokuapp.com/scrape?url=manganelo.tv/';
  final String actualBaseUrl = 'https://manganelo.tv';

  @override
  List<MangaPreview> extractFrontPageMangas(String frontPageHtml) {
    webScraper.loadFromString(frontPageHtml);
    List<Map<String, dynamic>> titleSrcList = webScraper.getElement(
        'div.content-homepage-item > a > img', ['alt', 'src', 'data-src']);
    List<Map<String, dynamic>> refList = webScraper.getElement(
        'div.content-homepage-item > div.content-homepage-item-right  > h3 > a',
        ['href']);

    List<MangaPreview> mangaTileDataList = [];
    for (int i = 0; i < titleSrcList.length; i++) {
      final Map<String, dynamic> e = titleSrcList[i];
      final String title = e['attributes']['alt'].toString();
      final String src = e['attributes']['src'].toString();
      final String imgSrc = src.isEmpty || src == 'null'
          ? "$baseUrl${e['attributes']['data-src']}"
          : '$baseUrl$src';
      final String ref =
          '$actualBaseUrl${refList[i]['attributes']['href'].toString()}';
      mangaTileDataList.add(MangaPreview(title, imgSrc, ref));
    }
    return mangaTileDataList;
  }

  @override
  Chapter extractChapterInfo(String chapterInfoHtml) {
    // TODO: implement extractChapterInfo
    throw UnimplementedError();
  }

  @override
  Manga extractMangaInfo(String mangaPageHtml) {
    // TODO: implement extractMangaInfo
    throw UnimplementedError();
  }

  @override
  List<MangaPreview> extractSearchResults(String searchPageHtml) {
    // TODO: implement extractSearchResults
    throw UnimplementedError();
  }
}
