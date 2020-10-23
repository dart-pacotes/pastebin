enum Visibility {
  public,
  unlisted,
  private,
}

extension VisibilityExtension on Visibility {
  static const Map<Visibility, String> values = {
    Visibility.public: '0',
    Visibility.unlisted: '1',
    Visibility.private: '2',
  };

  String value() {
    return values[this];
  }
}
