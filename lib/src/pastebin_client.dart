import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'models/models.dart';

///
/// Dart API for connecting with Pastebin API.
/// All methods are asynchronous so they return a Future and the results
/// are instances of [Either] monad so that no errors are thrown.
///
abstract class PastebinClient {
  ///
  /// Publishes a paste in Pastebin. By default only the text (`pasteText`)
  /// of the paste to publish is required, which means that the paste will not
  /// have a title, author or expiration date. These pastes are also public and
  /// in the `text` format.
  ///
  /// To provide values for these settings, pass an instance of [PasteOptions]
  /// in the `options` field.
  ///
  Future<Either<Uri, RequestError>> paste({
    required final String pasteText,
    final PasteOptions? options,
  });

  ///
  /// Generates a new Pastebin API user key. This key is used to identify a
  /// Pastebin user and is required to retrieve pastes of a user, delete a user
  /// paste, retrieve the information and settings of a user or retrieve the raw
  /// paste of a user.
  ///
  /// It takes on `username` and `password` which is the username and password
  /// used to login in Pastebin.
  ///
  Future<Either<String, RequestError>> apiUserKey({
    required final String username,
    required final String password,
  });

  ///
  /// Retrieves the pastes of a user as a [List] of [Paste]. By default the
  /// number of pastes to retrieve is limited to 50, but another values greater
  /// than 0 can be passed.
  ///
  Future<Either<List<Paste>, RequestError>> pastes({
    required final String userKey,
    final int limit = 50,
  });

  ///
  /// Deletes a user paste.
  ///
  Future<Either<void, RequestError>> delete({
    required final String pasteKey,
    required final String userKey,
  });

  ///
  /// Retrieves information of a user identified by `userKey`.
  ///
  Future<Either<UserInfo, RequestError>> userInfo({
    required final String userKey,
  });

  ///
  /// Retrieves a UTF-8 string with the raw text of a paste. To retrieve a
  /// private or unlisted paste, `userKey` needs to be included with the user
  /// identifier and `visibility` set to [Visibility.private] or
  /// [Visibility.unlisted].
  ///
  Future<Either<String, RequestError>> rawPaste({
    required final String pasteKey,
    required final Visibility visibility,
    final String? userKey,
  });
}
