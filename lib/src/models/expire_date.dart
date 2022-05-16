///
/// Possible values for expiration dates of a Pastebin [Paste]
///
enum ExpireDate {
  never,
  tenMinutes,
  oneHour,
  oneDay,
  oneWeek,
  oneMonth,
  sixMonths,
  oneYear,
}

extension ExpireDateExtension on ExpireDate? {
  static const Map<ExpireDate, String> values = {
    ExpireDate.never: 'N',
    ExpireDate.tenMinutes: '10M',
    ExpireDate.oneHour: '1H',
    ExpireDate.oneDay: '1D',
    ExpireDate.oneWeek: '1W',
    ExpireDate.oneMonth: '1M',
    ExpireDate.sixMonths: '6M',
    ExpireDate.oneYear: '1Y',
  };

  static ExpireDate parse(
    final String? expireDate,
    final MapEntry<ExpireDate, String>? Function() onError,
  ) {
    return values.entries
        .firstWhere((entry) => entry.value == expireDate, orElse: onError as MapEntry<ExpireDate, String> Function()?)
        .key;
  }

  static ExpireDate tryParse(final String? expireDate) =>
      parse(expireDate, () => null);

  String? value() {
    return values[this!];
  }
}
