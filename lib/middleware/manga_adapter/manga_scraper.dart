import 'package:flutter/foundation.dart';
import 'package:manga_flutter/model/chapter.dart';
import 'package:manga_flutter/model/manga.dart';
import 'package:manga_flutter/model/manga_preview.dart';
import 'package:web_scraper/web_scraper.dart';

abstract class BaseMangaScraper {
  abstract final String baseUrl;
  @protected
  final WebScraper webScraper = new WebScraper();

  List<MangaPreview> extractFrontPageMangas(String frontPageHtml);
  Manga extractMangaInfo(String mangaPageHtml);
  Chapter extractChapterInfo(String chapterInfoHtml);
  List<MangaPreview> extractSearchResults(String searchPageHtml);
}
