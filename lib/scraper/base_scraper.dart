import 'package:web_scraper/web_scraper.dart';

abstract class BaseScraper {
  abstract final String baseUrl;
  late WebScraper webScraper = WebScraper(baseUrl);
}
