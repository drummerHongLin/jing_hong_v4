import 'package:flutter/widgets.dart' show GlobalKey, IconData;

class LifeExperience {
  LifeExperience(
      {required this.content,
      required this.date,
      required this.url,
      required this.icon})
      : key = GlobalKey(debugLabel: date);

  String content;
  String date;
  String url;
  IconData icon;

  GlobalKey key;
}