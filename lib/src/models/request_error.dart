///
/// Base type for an error that can occur when consuming the Pastebin API
///
abstract class RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid api_option'
///
class InvalidApiOption extends RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid api_dev_key'
///
class InvalidApiDevKey extends RequestError {}

///
/// Corresponds to API response 'Bad API request, maximum number
/// of 25 unlisted pastes for your free account'
///
class ExceededMaximumNumberOfUnlistedPastes extends RequestError {}

///
/// Corresponds to API response 'Bad API request, maximum number
/// of 10 private pastes for your free account'
///
class ExceededMaximumNumberOfPrivatePastes extends RequestError {}

///
/// Corresponds to API response 'Bad API request, api_paste_code was empty'
///
class EmptyApiPasteCode extends RequestError {}

///
/// Corresponds to API response 'Bad API request, maximum paste
/// file size exceeded'
///
class ExceededMaximumPasteFileSize extends RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid api_paste_expire_date'
///
class InvalidApiPasteExpireDate extends RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid api_paste_private'
///
class InvalidApiPasteVisibility extends RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid api_paste_format'
///
class InvalidApiPasteFormat extends RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid api_user_key'
///
class InvalidApiUserKey extends RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid or
/// expired api_user_key'
///
class ExpiredUserKey extends RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid login'
///
class InvalidUserCredentials extends RequestError {}

///
/// Corresponds to API response 'Bad API request, account not active'
///
class AccountNotActive extends RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid POST parameters'
///
class InvalidParameters extends RequestError {}

///
/// Corresponds to API response 'Bad API request, invalid permission to view
/// this paste or invalid api_paste_key' or 'Bad API request,
/// invalid permission to remove paste'
///
class InsufficientPermissions extends RequestError {}

///
/// Corresponds to API response 'Bad API request, use POST request, not GET'
///
class InvalidRequestVerb extends RequestError {}

///
/// Occurs when the connection between the client and the
/// Pastebin API Server fails
///
class NetworkError extends RequestError {}

///
/// Occurs when the response status code is 404; Not Found
///
class NotFound extends RequestError {}
