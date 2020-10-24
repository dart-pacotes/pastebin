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
    @required final List<String> apiDevKeys,
    @required final http.Client httpClient,
  })  : _apiDevKeys = List.from(apiDevKeys, growable: true),
        _httpClient = httpClient;

  @override
  Future<Either<String, RequestError>> apiUserKey({
    final String username,
    final String password,
  }) async {
    final body = <String, String>{
      'api_user_name': username,
      'api_user_password': password,
    };

    final response = await apiRequest(
      body: body,
      apiOption: ApiOption.newUserKey,
    );

    return response.fold(
      (l) => Left(l.body),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<void, RequestError>> delete({
    final String pasteKey,
    final String userKey,
  }) {
    final body = <String, String>{
      'api_user_key': userKey,
      'api_paste_key': userKey,
    };

    return apiRequest(
      body: body,
      apiOption: ApiOption.deletePaste,
    );
  }

  @override
  Future<Either<void, RequestError>> paste({
    @required final String pasteText,
    final PasteOptions options,
  }) async {
    final body = <String, String>{
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

    return apiRequest(
      body: body,
      apiOption: ApiOption.paste,
    );
  }

  @override
  Future<Either<List<Paste>, RequestError>> pastes({
    final String userKey,
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
      (l) => Left(
        Paste.fromXmlDocument(
          XmlDocument.parse(l.body),
        ),
      ),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<String, RequestError>> rawPaste({
    @required final String pasteKey,
    @required final Visibility visibility,
    final String userKey,
  }) async {
    final body = <String, String>{
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
      (l) => Left(l.body),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<UserInfo, RequestError>> userInfo({
    final String userKey,
  }) async {
    final body = <String, String>{
      'api_user_key': userKey,
    };

    final response = await apiRequest(
      body: body,
      apiOption: ApiOption.retrieveUserDetails,
    );

    return response.fold(
      (l) => Left(
        UserInfo.fromXmlNode(
          XmlDocument.parse(l.body).getElement('user'),
        ),
      ),
      (r) => Right(r),
    );
  }

  String get apiDevKey => _apiDevKeys.first;

  @visibleForTesting
  Future<Either<http.Response, RequestError>> apiRequest({
    @required final Map<String, String> body,
    @required final ApiOption apiOption,
  }) async {
    try {
      final url = apiOption.url();

      final formMap = <String, String>{
        'api_option': apiOption.value(),
        'api_dev_key': apiDevKey,
        ...body
      };

      var response;

      if (apiOption == ApiOption.rawPaste) {
        response = await _httpClient.get('$url/${body['api_paste_key']}');
      } else {
        response = await _httpClient.post(
          url,
          body: formMap,
          encoding: utf8,
        );
      }

      return mapResponse(response).fold(
        (l) => Left(l),
        (r) {
          if (_apiDevKeys.length > 1) {
            if (r is ExceededMaximumNumberOfPrivatePastes ||
                r is ExceededMaximumNumberOfUnlistedPastes ||
                r is InvalidApiDevKey) {
              _apiDevKeys.removeAt(0);

              return apiRequest(body: body, apiOption: apiOption);
            }
          }
          return Right(r);
        },
      );
    } on Object catch (_) {
      return Right(NetworkError());
    }
  }

  @visibleForTesting
  Either<http.Response, RequestError> mapResponse(
    final http.Response response,
  ) {
    if (response.statusCode == 404) {
      return Right(NotFound());
    }

    switch (response.body) {
      case 'Bad API request, invalid api_option':
        return Right(InvalidApiOption());
      case 'Bad API request, invalid api_dev_key':
        return Right(InvalidApiDevKey());
      case '''Bad API request, maximum number of 25 unlisted pastes for your free account''':
        return Right(ExceededMaximumNumberOfUnlistedPastes());
      case '''Bad API request, maximum number of 10 private pastes for your free account''':
        return Right(ExceededMaximumNumberOfPrivatePastes());
      case 'Bad API request, api_paste_code was empty':
        return Right(EmptyApiPasteCode());
      case 'Bad API request, maximum paste file size exceeded':
        return Right(ExceededMaximumPasteFileSize());
      case 'Bad API request, invalid api_paste_expire_date':
        return Right(InvalidApiPasteExpireDate());
      case 'Bad API request, invalid api_paste_private':
        return Right(InvalidApiPasteVisibility());
      case 'Bad API request, invalid api_paste_format':
        return Right(InvalidApiPasteFormat());
      case 'Bad API request, invalid api_user_key':
        return Right(InvalidApiUserKey());
      case 'Bad API request, invalid or expired api_user_key':
        return Right(ExpiredUserKey());
      case 'Bad API request, use POST request, not GET':
        return Right(InvalidRequestVerb());
      case 'Bad API request, invalid login':
        return Right(InvalidUserCredentials());
      case 'Bad API request, account not active':
        return Right(AccountNotActive());
      case 'Bad API request, invalid POST parameters':
        return Right(InvalidParameters());
      case 'Bad API request, invalid permission to remove paste':
        return Right(InsufficientPermissions());
      case '''Bad API request, invalid permission to view this paste or invalid api_paste_key''':
        return Right(InsufficientPermissions());
      default:
        return Left(response);
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
