///
/// Options available in Pastebin API
///
enum ApiOption {
  paste,
  newUserKey,
  listPastes,
  deletePaste,
  retrieveUserDetails,
  userRawPaste,
  rawPaste,
}

extension ApiOptionExtension on ApiOption {
  String value() {
    switch (this) {
      case ApiOption.paste:
        return 'paste';
      case ApiOption.newUserKey:
        return 'new_user_key';
      case ApiOption.listPastes:
        return 'list';
      case ApiOption.deletePaste:
        return 'delete';
      case ApiOption.retrieveUserDetails:
        return 'userdetails';
      case ApiOption.userRawPaste:
        return 'show_paste';
      default:
        return 'raw_paste';
    }
  }
}
