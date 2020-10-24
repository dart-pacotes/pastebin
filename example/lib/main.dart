import 'package:pastebin/pastebin.dart';

void main() async {
  final primaryApiDevKey = '<your_api_dev_key>';

  final fallbackApiDevKey = '<your_api_dev_key>';

  final apiUserKey = '<your_api_user_key>';

  final username = '<your_pastebin_username>';

  final password = '<your_pastebin_password>';

  // Using Official Pastebin API with a single API Dev Key
  var pastebinClient = withSingleApiDevKey(
    apiDevKey: primaryApiDevKey,
  );

  // Using Official Pastebin API with multiple API Dev Key
  pastebinClient = withMultipleApiDevKey(
    apiDevKeys: [
      primaryApiDevKey,
      fallbackApiDevKey,
    ],
  );

  // Publish new paste
  final pasteText = 'Hello World!';

  final pasteResult = await pastebinClient.paste(pasteText: pasteText);

  print(pasteResult);

  // Publish new paste with options
  final pasteName = 'Hello World from Dart';

  final pasteWithOptionsResult = await pastebinClient.paste(
    pasteText: pasteText,
    options: PasteOptions(
      pasteName: pasteName,
      pasteVisiblity: Visibility.public,
      pasteFormat: Format.dart,
      apiUserKey: apiUserKey,
      pasteExpireDate: ExpireDate.oneDay,
    ),
  );

  print(pasteWithOptionsResult);

  // Generate Pastebin API user key
  final apiUserKeyResult = await pastebinClient.apiUserKey(
    username: username,
    password: password,
  );

  print(apiUserKeyResult);

  // Delete paste
  final pasteKey = '<paste_key>';

  final deletePasteResult = await pastebinClient.delete(
    pasteKey: pasteKey,
    userKey: apiUserKey,
  );

  print(deletePasteResult);

  // Retrieve user pastes
  final limit = 100;

  final pastesResult = await pastebinClient.pastes(
    limit: limit,
    userKey: apiUserKey,
  );

  print(pastesResult);

  // Retrieve raw paste of user
  var pasteVisibility = Visibility.private;

  final rawPasteOfUserResult = await pastebinClient.rawPaste(
    pasteKey: pasteKey,
    visibility: pasteVisibility,
    userKey: apiUserKey,
  );

  print(rawPasteOfUserResult);

  // Retrieve raw paste
  pasteVisibility = Visibility.public;

  final rawPasteResult = await pastebinClient.rawPaste(
    pasteKey: pasteKey,
    visibility: pasteVisibility,
  );

  print(rawPasteResult);

  // Retrieve user info

  final userInfoResult = await pastebinClient.userInfo(
    userKey: apiUserKey,
  );

  print(userInfoResult);
}
