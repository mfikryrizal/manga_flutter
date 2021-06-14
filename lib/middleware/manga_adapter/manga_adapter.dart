import 'package:manga_flutter/middleware/manga_adapter/manga_client.dart';
import 'package:manga_flutter/middleware/manga_adapter/manga_scraper.dart';
import 'package:manga_flutter/model/chapter.dart';
import 'package:manga_flutter/model/manga.dart';
import 'package:manga_flutter/model/manga_preview.dart';

class MangaAdapter {
  final BaseMangaClient _client;
  final BaseMangaScraper _scraper;

  MangaAdapter(this._client, this._scraper);

  Future<List<MangaPreview>> getFrontPageMangas() async {
    return _scraper.extractFrontPageMangas(await _client.loadFrontPage());
  }

  Future<Manga> getMangaInfo(String mangaId) async {
    return _scraper.extractMangaInfo(await _client.loadMangaPage(mangaId));
  }

  Future<Chapter> getChapterInfo(String mangaId, String chapterId) async {
    return _scraper
        .extractChapterInfo(await _client.loadChapterPage(mangaId, chapterId));
  }

  Future<List<MangaPreview>> searchManga(
      String title, List<Map<String, String>>? params) async {
    return _scraper
        .extractSearchResults(await _client.loadSearchPage(title, params));
  }
}
