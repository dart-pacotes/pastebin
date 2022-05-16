# pastebin

A pure Dart Pastebin API Wrapper.

## Features

This package covers every endpoint disclosed in [Pastebin API documentation](https://pastebin.com/doc_api#9) (as of 16 May, 2022). The following table links the endpoints to the respective package functions:

|API Endpoints|Function|Description|
|-------------|--------|-----------|
|[`/api/api_post.php` (2-8)](https://pastebin.com/doc_api#2)|[`paste(pasteText, options)`](https://pub.dev/documentation/pastebin/latest/pastebin/PastebinClient/paste.html)|Publishes a paste (with support for optional parameters) in Pastebin.|
|[`/api/api_login.php` (9)](https://pastebin.com/doc_api#9)|[`apiUserKey(username, password)`](https://pub.dev/documentation/pastebin/latest/pastebin/PastebinClient/apiUserKey.html)|Retrieves and refreshes user API key (not developer key).|
|[`/api/api_post.php` (10)](https://pastebin.com/doc_api#10)|[`pastes(userKey, limit=50)`](https://pub.dev/documentation/pastebin/latest/pastebin/PastebinClient/pastes.html)|Fetches an user pastes, with support for limiting how many pastes are returned.|
|[`/api/api_post.php` (11)](https://pastebin.com/doc_api#11)|[`delete(pasteKey, userKey)`](https://pub.dev/documentation/pastebin/latest/pastebin/PastebinClient/delete.html)|Deletes an user paste.|
|[`/api/api_post.php` (12)](https://pastebin.com/doc_api#12)|[`userInfo(userKey)`](https://pub.dev/documentation/pastebin/latest/pastebin/PastebinClient/userInfo.html)|Obtains user information and settings.|
|[`/api/api_raw.php` (13)](https://pastebin.com/doc_api#13)|[`rawPaste(pasteKey, visibility, userKey)`](https://pub.dev/documentation/pastebin/latest/pastebin/PastebinClient/userInfo.html)|Gets the raw paste (full text) of a user paste.|
|[`/api/raw.php` (14)](https://pastebin.com/doc_api#14)|[`rawPaste(pasteKey, visibility)`](https://pub.dev/documentation/pastebin/latest/pastebin/PastebinClient/userInfo.html)|Gets the raw paste (full text) of paste.|

There is also support for multiple API key ingestion, a neat feature for making sure that pastes are published, even if you are rate limited by Pastebin.

```dart
// Using Official Pastebin API with a single API Dev Key
var pastebinClient = withSingleApiDevKey(
    apiDevKey: primaryApiDevKey,
);

// Using Official Pastebin API with multiple API Dev Key
pastebinClient = withMultipleApiDevKey(
    apiDevKeys: [
        primaryApiDevKey,
        fallbackApiDevKey1,
        fallbackApiDevKey2,
        ...
        fallbackApiDevKeyN,
    ],
);
```

## Side Effects

Powered by Dart null sound + [`dartz`](https://pub.dev/packages/dartz) monads, this package is free of null issues and side effects. This is to prevent the throw of any exception that may not be known and caught by developers, and to make sure that information is consistent by contract.

Every HTTP request returns an `Either` monad that either returns the response result on the right hand, or `ResponseError` instance on the left hand that is typed to each possible Pastebin error (see available errors [here](https://pub.dev/documentation/pastebin/latest/pastebin/RequestError-class.html)).

## Why use pastebin.dart?

The main use case that inspired the development of this package, is to provide developers (mostly indie) a way to publish and read app logs for free.

---

### Bugs and Contributions

Found any bug (including typos) in the package? Do you have any suggestion or feature to include for future releases? Please create an issue via GitHub in order to track each contribution. Also, pull requests are very welcome!

### Disclaimer

This is not an official library/SDK implemented by the Pastebin team, but rather a developer implementation that uses it.