import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'official_pastebin_client.dart';
import 'pastebin_client.dart';

///
/// Returns an instance of [OfficialPastebinClient] which
/// takes on a single Pastebin API developer key.
///
PastebinClient withSingleApiDevKey({
  required final String apiDevKey,
}) {
  return OfficialPastebinClient(
    apiDevKeys: [apiDevKey],
    httpClient: http.Client(),
  );
}

///
/// Returns an instance of [OfficialPastebinClient] which
/// takes on multiple Pastebin API developer keys.
/// The difference of this call and `withSingleApiDevKey` is that
/// by providing multiple api dev keys, if a request fails due to
/// exceeding maximum amount of pastes is reached or the api dev key is invalid
/// the request is resent with a different api dev key.
///
PastebinClient withMultipleApiDevKey({
  required final List<String> apiDevKeys,
}) {
  return OfficialPastebinClient(
    apiDevKeys: apiDevKeys,
    httpClient: http.Client(),
  );
}
