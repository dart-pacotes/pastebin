import 'package:http/http.dart';
import 'package:pastebin/pastebin.dart';
import 'package:pastebin/src/official_pastebin_client.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  final mockHttpClient = MockHttpClient();

  final singleOfficialPastebinClient = OfficialPastebinClient(
    apiDevKeys: ['api_key'],
    httpClient: mockHttpClient,
  );

  final doubleKeyOfficialPastebinClient = OfficialPastebinClient(
    apiDevKeys: ['api_key', 'api_key2'],
    httpClient: mockHttpClient,
  );

  final tripleKeyOfficialPastebinClient = OfficialPastebinClient(
    apiDevKeys: ['api_key', 'api_key2', 'api_key3'],
    httpClient: mockHttpClient,
  );

  group(
    'OfficialPastebinClient',
    () {
      test(
        '''maps a NotFound object in the right hand if a request response status code is 404''',
        () {
          final response = Response('', 404);

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is NotFound, isTrue);
        },
      );

      test(
        '''maps a InvalidApiOption object in the right hand if a request response body matches "Bad API request, invalid api_option"''',
        () {
          final response = Response('Bad API request, invalid api_option', 400);

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InvalidApiOption, isTrue);
        },
      );

      test(
        '''maps a InvalidApiDevKey object in the right hand if a request response body matches "Bad API request, invalid api_dev_key"''',
        () {
          final response = Response(
            'Bad API request, invalid api_dev_key',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InvalidApiDevKey, isTrue);
        },
      );
      test(
        '''maps a ExceededMaximumNumberOfUnlistedPastes object in the right hand if a request response body matches "Bad API request, maximum number of 25 unlisted pastes for your free account"''',
        () {
          final response = Response(
            '''Bad API request, maximum number of 25 unlisted pastes for your free account''',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is ExceededMaximumNumberOfUnlistedPastes, isTrue);
        },
      );
      test(
        '''maps a ExceededMaximumNumberOfPrivatePastes object in the right hand if a request response body matches "Bad API request, maximum number of 10 private pastes for your free account"''',
        () {
          final response = Response(
            '''Bad API request, maximum number of 10 private pastes for your free account''',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is ExceededMaximumNumberOfPrivatePastes, isTrue);
        },
      );
      test(
        '''maps a EmptyApiPasteCode object in the right hand if a request response body matches "Bad API request, api_paste_code was empty"''',
        () {
          final response = Response(
            'Bad API request, api_paste_code was empty',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is EmptyApiPasteCode, isTrue);
        },
      );
      test(
        '''maps a ExceededMaximumPasteFileSize object in the right hand if a request response body matches "Bad API request, maximum paste file size exceeded"''',
        () {
          final response = Response(
            'Bad API request, maximum paste file size exceeded',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is ExceededMaximumPasteFileSize, isTrue);
        },
      );
      test(
        '''maps a InvalidApiPasteExpireDate object in the right hand if a request response body matches "Bad API request, invalid api_paste_expire_date"''',
        () {
          final response = Response(
            'Bad API request, invalid api_paste_expire_date',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InvalidApiPasteExpireDate, isTrue);
        },
      );
      test(
        '''maps a InvalidApiPasteVisibility object in the right hand if a request response body matches "Bad API request, invalid api_paste_private"''',
        () {
          final response = Response(
            'Bad API request, invalid api_paste_private',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InvalidApiPasteVisibility, isTrue);
        },
      );
      test(
        '''maps a InvalidApiPasteFormat object in the right hand if a request response body matches "Bad API request, invalid api_paste_format"''',
        () {
          final response = Response(
            'Bad API request, invalid api_paste_format',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InvalidApiPasteFormat, isTrue);
        },
      );
      test(
        '''maps a InvalidApiUserKey object in the right hand if a request response body matches "Bad API request, invalid api_user_key"''',
        () {
          final response = Response(
            'Bad API request, invalid api_user_key',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InvalidApiUserKey, isTrue);
        },
      );
      test(
        '''maps a ExpiredUserKey object in the right hand if a request response body matches "Bad API request, invalid or expired api_user_key"''',
        () {
          final response = Response(
            'Bad API request, invalid or expired api_user_key',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is ExpiredUserKey, isTrue);
        },
      );
      test(
        '''maps a InvalidRequestVerb object in the right hand if a request response body matches "Bad API request, use POST request, not GET"''',
        () {
          final response = Response(
            'Bad API request, use POST request, not GET',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InvalidRequestVerb, isTrue);
        },
      );
      test(
        '''maps a InvalidUserCredentials object in the right hand if a request response body matches "Bad API request, invalid login"''',
        () {
          final response = Response('Bad API request, invalid login', 400);

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InvalidUserCredentials, isTrue);
        },
      );
      test(
        '''maps a AccountNotActive object in the right hand if a request response body matches "Bad API request, account not active"''',
        () {
          final response = Response('Bad API request, account not active', 400);

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is AccountNotActive, isTrue);
        },
      );
      test(
        '''maps a InvalidParameters object in the right hand if a request response body matches "Bad API request, invalid POST parameters"''',
        () {
          final response = Response(
            'Bad API request, invalid POST parameters',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InvalidParameters, isTrue);
        },
      );
      test(
        '''maps a InsufficientPermissions object in the right hand if a request response body matches "Bad API request, invalid permission to remove paste"''',
        () {
          final response = Response(
            'Bad API request, invalid permission to remove paste',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InsufficientPermissions, isTrue);
        },
      );
      test(
        '''maps a InsufficientPermissions object in the right hand if a request response body matches "Bad API request, invalid permission to view this paste or invalid api_paste_key"''',
        () {
          final response = Response(
            '''Bad API request, invalid permission to view this paste or invalid api_paste_key''',
            400,
          );

          final result = singleOfficialPastebinClient.mapResponse(response);

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is InsufficientPermissions, isTrue);
        },
      );

      test(
        '''maps a NetworkError object in the right hand if http.Client.get throws an error''',
        () async {
          when(() => mockHttpClient.get(any())).thenThrow('connection issue');

          final result = await singleOfficialPastebinClient.apiRequest(
            body: {},
            apiOption: ApiOption.rawPaste,
          );

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is NetworkError, isTrue);
        },
      );

      test(
        '''maps a NetworkError object in the right hand if http.Client.post throws an error''',
        () async {
          when(
            () => mockHttpClient.post(
              any(),
              body: any(named: 'body'),
              encoding: any(named: 'encoding'),
            ),
          ).thenThrow('connection issue');

          final result = await singleOfficialPastebinClient.apiRequest(
            body: {},
            apiOption: ApiOption.deletePaste,
          );

          final rightHand = result.fold(null, (r) => r);

          expect(rightHand is NetworkError, isTrue);

          reset(mockHttpClient);
        },
      );

      test(
        '''does not retry the api request with a new api dev key if only one api dev key is provided''',
        () async {
          final response = Response(
            'Bad API request, invalid api_dev_key',
            400,
          );

          when(
            () => mockHttpClient.post(
              any(),
              body: any(named: 'body'),
              encoding: any(named: 'encoding'),
            ),
          ).thenAnswer(
            (_) => Future.value(response),
          );

          await singleOfficialPastebinClient.apiRequest(
            body: {},
            apiOption: ApiOption.paste,
          );

          verify(
            () => mockHttpClient.post(
              any(),
              body: any(named: 'body'),
              encoding: any(named: 'encoding'),
            ),
          ).called(1);
        },
      );

      test(
        '''retries the api request with a new api dev key if more than one api dev key is provided and the mapped response if a right hand with ExceededMaximumNumberOfPrivatePastes object''',
        () async {
          final response = Response(
            '''Bad API request, maximum number of 10 private pastes for your free account''',
            400,
          );

          when(
            () => mockHttpClient.post(
              any(),
              body: any(named: 'body'),
              encoding: any(named: 'encoding'),
            ),
          ).thenAnswer(
            (_) => Future.value(response),
          );

          await doubleKeyOfficialPastebinClient.apiRequest(
            body: {},
            apiOption: ApiOption.paste,
          );

          verify(
            () => mockHttpClient.post(
              any(),
              body: any(named: 'body'),
              encoding: any(named: 'encoding'),
            ),
          ).called(2);
        },
      );

      test(
        '''retries the api request with a new api dev key if more than one api dev key is provided and the mapped response if a right hand with ExceededMaximumNumberOfUnlistedPastes object''',
        () async {
          final response = Response(
            '''Bad API request, maximum number of 25 unlisted pastes for your free account''',
            400,
          );

          when(
            () => mockHttpClient.post(
              any(),
              body: any(named: 'body'),
              encoding: any(named: 'encoding'),
            ),
          ).thenAnswer(
            (_) => Future.value(response),
          );

          await tripleKeyOfficialPastebinClient.apiRequest(
            body: {},
            apiOption: ApiOption.paste,
          );

          verify(
            () => mockHttpClient.post(
              any(),
              body: any(named: 'body'),
              encoding: any(named: 'encoding'),
            ),
          ).called(3);
        },
      );

      test(
        '''calls http.Client.get if api option is ApiOption.rawPaste''',
        () async {
          final response = Response('', 200);

          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) => Future.value(response),
          );

          await singleOfficialPastebinClient.apiRequest(
            body: {},
            apiOption: ApiOption.rawPaste,
          );

          verify(() => mockHttpClient.get(any())).called(1);
        },
      );
    },
  );
}
