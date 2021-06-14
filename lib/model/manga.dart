import 'package:flutter/foundation.dart';

@immutable
class Manga {
  final String title;
  final String description;
  final double rating;
  final List<String> artist;
  final List<String> genres;
  final List<Map<String, String>> chapters;

  Manga({
    required this.title,
    required this.description,
    required this.rating,
    required this.artist,
    required this.genres,
    required this.chapters,
  });
}
