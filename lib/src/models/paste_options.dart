import 'expire_date.dart';
import 'format.dart';
import 'visibility.dart';

class PasteOptions {
  final String apiUserKey;

  final String pasteName;

  final Format pasteFormat;

  final Visibility pasteVisiblity;

  final ExpireDate pasteExpireDate;

  const PasteOptions({
    this.apiUserKey,
    this.pasteName,
    this.pasteFormat,
    this.pasteVisiblity,
    this.pasteExpireDate,
  });
}
