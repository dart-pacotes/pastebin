import 'package:meta/meta.dart';

import 'models.dart';

class Paste {
  final String key;

  final DateTime createdDate;

  final DateTime expiredDate;

  final int sizeInBytes;

  final Visibility visibility;

  final Format format;

  final Uri url;

  final int hits;

  const Paste({
    @required this.createdDate,
    @required this.expiredDate,
    @required this.format,
    @required this.hits,
    @required this.key,
    @required this.sizeInBytes,
    @required this.url,
    @required this.visibility,
  });
}
