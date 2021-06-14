import 'package:flutter/foundation.dart';

@immutable
class MangaPreview {
  const MangaPreview(this.title, this.imgSrc, this.ref);
  final String title;
  final String imgSrc;
  final String ref;
}
