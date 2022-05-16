import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

import 'models/models.dart';
import 'pastebin_client.dart';

class OfficialPastebinClient extends PastebinClient {
  final List<String> _apiDevKeys;

  final http.Client _httpClient;

  OfficialPastebinClient({
    required final List<String> apiDevKeys,
    required final http.Client httpClient,
  })  : _apiDevKeys = List.from(apiDevKeys, growable: true),
        _httpClient = httpClient;

  @override
  Future<Either<RequestError, String>> apiUserKey({
    final String? username,
    final String? password,
  }) async {
    final body = <String, String?>{
      'api_user_name': username,
      'api_user_password': password,
    };

    final response = await apiRequest(
      body: body,
      apiOption: ApiOption.newUserKey,
    );

    return response.fold(
      (l) => Left(l),
      (r) => Right(r.body),
    );
  }

  @override
  Future<Either<RequestError, void>> delete({
    final String? pasteKey,
    final String? userKey,
  }) {
    final body = <String, String?>{
      'api_user_key': userKey,
      'api_paste_key': userKey,
    };

    return apiRequest(
      body: body,
      apiOption: ApiOption.deletePaste,
    );
  }

  @override
  Future<Either<RequestError, Uri>> paste({
    required final String pasteText,
    final PasteOptions? options,
  }) async {
    final body = <String, String?>{
      'api_paste_code': pasteText,
    };

    if (options != null) {
      body.addAll(
        {
          'api_user_key': options.apiUserKey,
          'api_paste_name': options.pasteName,
          'api_paste_format': options.pasteFormat?.value(),
          'api_paste_private': options.pasteVisiblity?.value(),
          'api_paste_expire_date': options.pasteExpireDate?.value(),
        },
      );
    }

    body.removeWhere((k, v) => v == null);

    final response = await apiRequest(
      body: body,
      apiOption: ApiOption.paste,
    );

    return response.fold(
      (l) => Left(l),
      (r) => Right(Uri.parse(r.body)),
    );
  }

  @override
  Future<Either<RequestError, List<Paste>>> pastes({
    final String? userKey,
    final int limit = 50,
  }) async {
    final body = <String, String>{
      'api_results_limit': limit.toString(),
      'api_user_key': userKey.toString(),
    };

    final response = await apiRequest(
      body: body,
      apiOption: ApiOption.listPastes,
    );

    return response.fold(
      (l) => Left(l),
      (r) => Right(
        Paste.fromXmlDocument(
          XmlDocument.parse(r.body),
        ),
      ),
    );
  }

  @override
  Future<Either<RequestError, String>> rawPaste({
    required final String pasteKey,
    required final Visibility visibility,
    final String? userKey,
  }) async {
    final body = <String, String?>{
      'api_paste_key': pasteKey,
    };

    final apiOption = visibility == Visibility.public
        ? ApiOption.rawPaste
        : ApiOption.userRawPaste;

    if (apiOption == ApiOption.userRawPaste) {
      body['api_user_key'] = userKey;
    }

    final response = await apiRequest(
      body: body,
      apiOption: apiOption,
    );

    return response.fold(
      (l) => Left(l),
      (r) => Right(r.body),
    );
  }

  @override
  Future<Either<RequestError, UserInfo>> userInfo({
    final String? userKey,
  }) async {
    final body = <String, String?>{
      'api_user_key': userKey,
    };

    final response = await apiRequest(
      body: body,
      apiOption: ApiOption.retrieveUserDetails,
    );

    return response.fold(
      (l) => Left(l),
      (r) => Right(
        UserInfo.fromXmlNode(
          XmlDocument.parse(r.body).getElement('user')!,
        ),
      ),
    );
  }

  String get apiDevKey => _apiDevKeys.first;

  @visibleForTesting
  Future<Either<RequestError, http.Response>> apiRequest({
    required final Map<String, String?> body,
    required final ApiOption apiOption,
  }) async {
    try {
      final url = apiOption.url();

      final formMap = <String, String?>{
        'api_option': apiOption.value(),
        'api_dev_key': apiDevKey,
        ...body
      };

      http.Response response;

      if (apiOption == ApiOption.rawPaste) {
        response = await _httpClient.get(uri('$url/${body['api_paste_key']}'));
      } else {
        response = await _httpClient.post(
          uri(url),
          body: formMap,
          encoding: utf8,
        );
      }

      return mapResponse(response).fold(
        (l) {
          if (_apiDevKeys.length > 1) {
            if (l is ExceededMaximumNumberOfPrivatePastes ||
                l is ExceededMaximumNumberOfUnlistedPastes ||
                l is InvalidApiDevKey) {
              _apiDevKeys.removeAt(0);

              return apiRequest(body: body, apiOption: apiOption);
            }
          }
          return Left(l);
        },
        (r) => Right(r),
      );
    } on Object catch (_) {
      return Left(NetworkError());
    }
  }

  @visibleForTesting
  Uri uri(final String url) {
    return Uri.parse(url);
  }

  @visibleForTesting
  Either<RequestError, http.Response> mapResponse(
    final http.Response response,
  ) {
    if (response.statusCode == 404) {
      return Left(NotFound());
    }

    switch (response.body) {
      case 'Bad API request, invalid api_option':
        return Left(InvalidApiOption());
      case 'Bad API request, invalid api_dev_key':
        return Left(InvalidApiDevKey());
      case '''Bad API request, maximum number of 25 unlisted pastes for your free account''':
        return Left(ExceededMaximumNumberOfUnlistedPastes());
      case '''Bad API request, maximum number of 10 private pastes for your free account''':
        return Left(ExceededMaximumNumberOfPrivatePastes());
      case 'Bad API request, api_paste_code was empty':
        return Left(EmptyApiPasteCode());
      case 'Bad API request, maximum paste file size exceeded':
        return Left(ExceededMaximumPasteFileSize());
      case 'Bad API request, invalid api_paste_expire_date':
        return Left(InvalidApiPasteExpireDate());
      case 'Bad API request, invalid api_paste_private':
        return Left(InvalidApiPasteVisibility());
      case 'Bad API request, invalid api_paste_format':
        return Left(InvalidApiPasteFormat());
      case 'Bad API request, invalid api_user_key':
        return Left(InvalidApiUserKey());
      case 'Bad API request, invalid or expired api_user_key':
        return Left(ExpiredUserKey());
      case 'Bad API request, use POST request, not GET':
        return Left(InvalidRequestVerb());
      case 'Bad API request, invalid login':
        return Left(InvalidUserCredentials());
      case 'Bad API request, account not active':
        return Left(AccountNotActive());
      case 'Bad API request, invalid POST parameters':
        return Left(InvalidParameters());
      case 'Bad API request, invalid permission to remove paste':
        return Left(InsufficientPermissions());
      case '''Bad API request, invalid permission to view this paste or invalid api_paste_key''':
        return Left(InsufficientPermissions());
      default:
        return Right(response);
    }
  }
}

extension OfficialApiOptionExtension on ApiOption {
  String url() {
    switch (this) {
      case ApiOption.newUserKey:
        return 'https://pastebin.com/api/api_login.php';
      case ApiOption.userRawPaste:
        return 'https://pastebin.com/api/api_raw.php';
      case ApiOption.rawPaste:
        return 'https://pastebin.com/raw';
      default:
        return 'https://pastebin.com/api/api_post.php';
    }
  }
}
