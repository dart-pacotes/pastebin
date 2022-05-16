import 'package:xml/xml.dart';

import 'models.dart';

///
/// Models a Pastebin paste
///
class Paste {
  final String? key;

  final DateTime createdDate;

  final DateTime expiredDate;

  final String? title;

  final int? sizeInBytes;

  final Visibility visibility;

  final Format format;

  final Uri? url;

  final int? hits;

  const Paste({
    required this.createdDate,
    required this.expiredDate,
    required this.format,
    required this.hits,
    required this.key,
    required this.sizeInBytes,
    required this.title,
    required this.url,
    required this.visibility,
  });

  static List<Paste> fromXmlDocument(final XmlDocument xmlDocument) {
    return xmlDocument.findElements('paste').map(fromXmlNode).toList();
  }

  static Paste fromXmlNode(final XmlNode xmlNode) {
    return Paste(
      createdDate: DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(xmlNode.getElement('paste_date')!.text)!,
      ),
      expiredDate: DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(xmlNode.getElement('paste_expire_date')!.text)!,
      ),
      format: FormatExtension.tryParse(
        xmlNode.getElement('paste_format_short')?.text,
      ),
      visibility: VisibilityExtension.tryParse(
        xmlNode.getElement('paste_private')?.text,
      ),
      hits: int.tryParse(xmlNode.getElement('paste_hits')!.text),
      key: xmlNode.getElement('paste_key')?.text,
      sizeInBytes: int.tryParse(xmlNode.getElement('paste_size')!.text),
      title: xmlNode.getElement('paste_title')?.text,
      url: Uri.tryParse(xmlNode.getElement('paste_url')!.text),
    );
  }
}
