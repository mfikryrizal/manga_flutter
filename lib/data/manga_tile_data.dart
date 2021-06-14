import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class MangaTileData {
  const MangaTileData(this.title, this.imgSrc, this.ref);
  final String title;
  final String imgSrc;
  final String ref;
}
