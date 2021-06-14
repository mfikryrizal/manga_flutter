import 'package:flutter/foundation.dart';

@immutable
class Chapter {
  final String title;
  final String no;
  final List<String> pageSrc;

  Chapter({
    required this.title,
    required this.no,
    required this.pageSrc,
  });
}
