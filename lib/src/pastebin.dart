import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'official_pastebin_client.dart';
import 'pastebin_client.dart';

PastebinClient withSingleApiDevKey({
  @required final String apiDevKey,
}) {
  return OfficialPastebinClient(
    apiDevKeys: [apiDevKey],
    httpClient: http.Client(),
  );
}

PastebinClient withMultipleApiDevKey({
  @required final List<String> apiDevKeys,
}) {
  return OfficialPastebinClient(
    apiDevKeys: apiDevKeys,
    httpClient: http.Client(),
  );
}
