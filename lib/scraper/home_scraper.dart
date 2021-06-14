import '../data/manga_tile_data.dart';
import 'base_scraper.dart';
import 'manganelo_base.dart';

class HomeScraper extends BaseScraper with ManganeloBase {
  Future<bool> loadPage() async {
    return webScraper.loadWebPage(scraperWithBasePath);
  }

  List<MangaTileData> getMangaTiles() {
    List<Map<String, dynamic>> titleSrcList = webScraper.getElement(
        'div.content-homepage-item > a > img', ['alt', 'src', 'data-src']);
    List<Map<String, dynamic>> refList = webScraper.getElement(
        'div.content-homepage-item > div.content-homepage-item-right  > h3 > a',
        ['href']);
    List<MangaTileData> mangaTileDataList = [];
    for (int i = 0; i < titleSrcList.length; i++) {
      final Map<String, dynamic> e = titleSrcList[i];
      final String title = e['attributes']['alt'].toString();
      final String src = e['attributes']['src'].toString();
      final String imgSrc = src.isEmpty || src == 'null'
          ? "$functionalUrl${e['attributes']['data-src']}"
          : '$functionalUrl$src';
      final String ref =
          '$actualBaseUrl${refList[i]['attributes']['href'].toString()}';
      mangaTileDataList.add(MangaTileData(title, imgSrc, ref));
    }
    return mangaTileDataList;
  }
}
