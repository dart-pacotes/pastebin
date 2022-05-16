///
/// Possible values for the visibility of a Pastebin [Paste]
///
enum Visibility {
  public,
  unlisted,
  private,
}

extension VisibilityExtension on Visibility? {
  static const Map<Visibility, String> values = {
    Visibility.public: '0',
    Visibility.unlisted: '1',
    Visibility.private: '2',
  };

  static Visibility parse(
    final String? visibility,
    final MapEntry<Visibility, String>? Function() onError,
  ) {
    return values.entries
        .firstWhere((entry) => entry.value == visibility,
            orElse: onError as MapEntry<Visibility, String> Function()?)
        .key;
  }

  static Visibility tryParse(final String? visibility) =>
      parse(visibility, () => null);

  String? value() {
    return values[this!];
  }
}
