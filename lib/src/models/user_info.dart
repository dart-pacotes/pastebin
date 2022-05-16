import 'package:xml/xml.dart';

import 'models.dart';

///
/// Models the information and settings of Pastebin user
///
class UserInfo {
  final String? userName;

  final Format format;

  final ExpireDate expiration;

  final Uri? avatarUrl;

  final Visibility visibility;

  final String? website;

  final String? email;

  final String? location;

  final bool? isPro;

  const UserInfo({
    required this.avatarUrl,
    required this.email,
    required this.expiration,
    required this.format,
    required this.isPro,
    required this.location,
    required this.userName,
    required this.visibility,
    required this.website,
  });

  static UserInfo fromXmlNode(final XmlNode xmlNode) {
    return UserInfo(
      avatarUrl: Uri.tryParse(
        xmlNode.getElement('user_avatar_url')?.text ?? '',
      ),
      email: xmlNode.getElement('user_email')?.text,
      expiration: ExpireDateExtension.tryParse(
        xmlNode.getElement('user_expiration')?.text,
      ),
      format: FormatExtension.tryParse(
        xmlNode.getElement('user_format_short')?.text,
      ),
      isPro: xmlNode.getElement('user_format_short')?.text.endsWith('1'),
      location: xmlNode.getElement('user_location')?.text,
      userName: xmlNode.getElement('user_name')?.text,
      visibility: VisibilityExtension.tryParse(
        xmlNode.getElement('user_private')?.text,
      ),
      website: xmlNode.getElement('user_website')?.text,
    );
  }
}
