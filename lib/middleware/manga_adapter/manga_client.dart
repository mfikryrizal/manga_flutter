import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class BaseMangaClient {
  abstract final String baseUrl;
  @protected
  late final Dio client;

  @protected
  Future<String> getHtml(String path) async {
    var response = await client.get(path);
    var realUri = response.realUri;
    log('Request URI: ${client.options.baseUrl}+$path\nActual URI: $realUri');
    return response.data.toString();
  }

  Future<String> loadFrontPage();
  Future<String> loadMangaPage(String mangaId);
  Future<String> loadChapterPage(String mangaId, String chapterId);
  Future<String> loadSearchPage(
      String title, List<Map<String, String>>? params);
  Future<String> loadPageImage(String mangaId, String chapterId, String pageNo);
}
