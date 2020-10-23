import 'package:meta/meta.dart';

import 'models.dart';

class UserInfo {
  final String userName;

  final Format format;

  final ExpireDate expiration;

  final Uri avatarUrl;

  final Visibility visibility;

  final String website;

  final String email;

  final String location;

  final bool isPro;

  const UserInfo({
    @required this.avatarUrl,
    @required this.email,
    @required this.expiration,
    @required this.format,
    @required this.isPro,
    @required this.location,
    @required this.userName,
    @required this.visibility,
    @required this.website,
  });
}
