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
/// this paste or invalid api_paste_key'
///
class InsufficientPermissions extends RequestError {}

///
/// Occurs when an error occurs in the connection between the client
/// and the Pastebin API Server
///
class NetworkError extends RequestError {}
