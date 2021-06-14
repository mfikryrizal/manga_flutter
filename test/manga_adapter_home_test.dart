import 'package:dio/dio.dart';
import 'package:file/memory.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:manga_flutter/middleware/manga_adapter/manga_adapter.dart';
import 'package:manga_flutter/middleware/manga_adapter/manganelo/manganelo_client.dart';
import 'package:manga_flutter/middleware/manga_adapter/manganelo/manganelo_scraper.dart';
import 'package:manga_flutter/model/manga_preview.dart';
import 'package:mime/mime.dart';

void main() async {
  test('Working call to load front page', () async {
    final mockData = 'Mock response data';
    final mockUrl =
        'https://scraper-private.herokuapp.com/scrape?url=manganelo.tv/';

    final dioAdapter = DioAdapter();
    dioAdapter.onGet('', (request) => request.reply(200, mockData));
    dioAdapter.onGet(mockUrl.toString(), (request) {
      return request.reply(200, mockData);
    });
    final dio = Dio();
    dio.httpClientAdapter = dioAdapter;
    final client = ManganeloClient(dio);

    // print(client.baseUrl);
    var response = await client.loadFrontPage();
    expect(response, mockData);
  });

  test('Extract MangaPreview from Html', () async {
    final mockHtml =
        '<div class="content-homepage-item"> <a data-tooltip="sticky_33975" class="tooltip item-img" rel="nofollow" href="/manga/manga-lk989167" title="I Only Want To Beat You"> <img class="img-loading" onerror="javascript:this.src="/res/img/404_not_found.webp";" alt="I Only Want To Beat You" src="/mangaimage/manga-lk989167.jpg"> <em class="item-rate">4.68</em> </a> <div class="content-homepage-item-right"> <h3 class="item-title"> <a data-tooltip="sticky_33975" class="tooltip a-h text-nowrap" href="/manga/manga-lk989167" title="I Only Want To Beat You">I Only Want To Beat You</a> </h3> <span class="text-nowrap item-author" title="Amadoji, Sasak Author"> Amadoji, Sasak </span> <p class="a-h item-chapter"> <a rel="nofollow" class="text-nowrap" href="/chapter/manga-lk989167/chapter-22" title="I Only Want To Beat You Chapter 22">Chapter 22</a> <i>8 hour ago </i> </p> <p class="a-h item-chapter"> <a rel="nofollow" class="text-nowrap" href="/chapter/manga-lk989167/chapter-21" title="I Only Want To Beat You Chapter 21">Chapter 21</a> <i>8 hour ago </i> </p> <p class="a-h item-chapter"> <a rel="nofollow" class="text-nowrap" href="/chapter/manga-lk989167/chapter-20" title="I Only Want To Beat You Chapter 20">Chapter 20</a> <i>8 hour ago </i> </p> </div> </div>';
    final scraper = ManganeloScraper();
    final targetImgSrc = scraper.baseUrl + '/mangaimage/manga-lk989167.jpg';
    final targetTitle = 'I Only Want To Beat You';
    final targetRef = scraper.actualBaseUrl + '/manga/manga-lk989167';

    final results = scraper.extractFrontPageMangas(mockHtml);
    expect(results.length, 1);
    expect(results[0].imgSrc, targetImgSrc);
    expect(results[0].title, targetTitle);
    expect(results[0].ref, targetRef);
  });

  test('Get MangaPreview and image from front page', () async {
    final mockHtml =
        '<div class="content-homepage-item"> <a data-tooltip="sticky_33975" class="tooltip item-img" rel="nofollow" href="/manga/manga-lk989167" title="I Only Want To Beat You"> <img class="img-loading" onerror="javascript:this.src="/res/img/404_not_found.webp";" alt="I Only Want To Beat You" src="/mangaimage/manga-lk989167.jpg"> <em class="item-rate">4.68</em> </a> <div class="content-homepage-item-right"> <h3 class="item-title"> <a data-tooltip="sticky_33975" class="tooltip a-h text-nowrap" href="/manga/manga-lk989167" title="I Only Want To Beat You">I Only Want To Beat You</a> </h3> <span class="text-nowrap item-author" title="Amadoji, Sasak Author"> Amadoji, Sasak </span> <p class="a-h item-chapter"> <a rel="nofollow" class="text-nowrap" href="/chapter/manga-lk989167/chapter-22" title="I Only Want To Beat You Chapter 22">Chapter 22</a> <i>8 hour ago </i> </p> <p class="a-h item-chapter"> <a rel="nofollow" class="text-nowrap" href="/chapter/manga-lk989167/chapter-21" title="I Only Want To Beat You Chapter 21">Chapter 21</a> <i>8 hour ago </i> </p> <p class="a-h item-chapter"> <a rel="nofollow" class="text-nowrap" href="/chapter/manga-lk989167/chapter-20" title="I Only Want To Beat You Chapter 20">Chapter 20</a> <i>8 hour ago </i> </p> </div> </div>'
        '<div class="content-homepage-item"> <a data-tooltip="sticky_33975" class="tooltip item-img" rel="nofollow" href="/manga/manga-lk989093" title="Fighting For Love"> <img class="img-loading" onerror="javascript:this.src="/res/img/404_not_found.webp";" alt="Fighting For Love" src="/mangaimage/manga-lk989093.jpg"> <em class="item-rate">4.44</em> </a> <div class="content-homepage-item-right"> <h3 class="item-title"> <a data-tooltip="sticky_33975" class="tooltip a-h text-nowrap" href="/manga/manga-lk989093" title="Fighting For Love">Fighting For Love</a> </h3> <span class="text-nowrap item-author" title="Cancan, Kuaikan Comics, Summerzoo Author"> Cancan, Kuaikan Comics, Summerzoo </span> <p class="a-h item-chapter"> <a rel="nofollow" class="text-nowrap" href="/chapter/manga-lk989093/chapter-29" title="Fighting For Love Chapter 29">Chapter 29</a> <i>5 hour ago </i> </p> <p class="a-h item-chapter"> <a rel="nofollow" class="text-nowrap" href="/chapter/manga-lk989093/chapter-28" title="Fighting For Love Chapter 28">Chapter 28</a> <i>5 hour ago </i> </p> <p class="a-h item-chapter"> <a rel="nofollow" class="text-nowrap" href="/chapter/manga-lk989093/chapter-27" title="Fighting For Love Chapter 27">Chapter 27</a> <i>5 hour ago </i> </p> </div> </div>';
    final scraper = ManganeloScraper();
    final targetImgSrc1 = scraper.baseUrl + '/mangaimage/manga-lk989167.jpg';
    final targetTitle1 = 'I Only Want To Beat You';
    final targetRef1 = scraper.actualBaseUrl + '/manga/manga-lk989167';
    final targetImgSrc2 = scraper.baseUrl + '/mangaimage/manga-lk989093.jpg';
    final targetTitle2 = 'Fighting For Love';
    final targetRef2 = scraper.actualBaseUrl + '/manga/manga-lk989093';
    final dioAdapter = DioAdapter()
      ..onGet('', (request) => request.reply(200, mockHtml));
    final client = ManganeloClient(Dio()..httpClientAdapter = dioAdapter);
    final adapter = MangaAdapter(client, scraper);

    final results = await adapter.getFrontPageMangas();
    expect(results.length, 2);
    expect(results[0].imgSrc, targetImgSrc1);
    expect(results[0].title, targetTitle1);
    expect(results[0].ref, targetRef1);
    expect(results[1].imgSrc, targetImgSrc2);
    expect(results[1].title, targetTitle2);
    expect(results[1].ref, targetRef2);

    var fs = MemoryFileSystem();
    for (MangaPreview m in results) {
      var response = await http.get(Uri.parse(m.imgSrc));
      var tf = await fs.file('temp_image.jpg').create();
      await tf.writeAsBytes(response.bodyBytes, flush: true);
      var mime = lookupMimeType(tf.path, headerBytes: [0xFF, 0xD8]);
      expect(mime!.startsWith('image'), true);
      tf.delete();
    }
  });
}
