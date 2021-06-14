import 'package:dio/dio.dart';
import 'package:manga_flutter/middleware/manga_adapter/manga_client.dart';

class ManganeloClient extends BaseMangaClient {
  @override
  final String baseUrl =
      'https://scraper-private.herokuapp.com/scrape?url=manganelo.tv/';

  /// dio client is injected for mocking purposes.
  /// baseUrl will be overriden
  ManganeloClient(Dio dio) {
    client = dio;
    client.options.baseUrl = baseUrl;
  }

  @override
  Future<String> loadFrontPage() async {
    return await getHtml('');
  }

  @override
  Future<String> loadChapterPage(String mangaId, String chapterId) {
    // TODO: implement loadChapterPage
    throw UnimplementedError();
  }

  @override
  Future<String> loadMangaPage(String mangaId) {
    // TODO: implement loadMangaPage
    throw UnimplementedError();
  }

  @override
  Future<String> loadPageImage(
      String mangaId, String chapterId, String pageNo) {
    // TODO: implement loadPageImage
    throw UnimplementedError();
  }

  @override
  Future<String> loadSearchPage(
      String title, List<Map<String, String>>? params) {
    // TODO: implement loadSearchPage
    throw UnimplementedError();
  }
}
