import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'models/models.dart';

abstract class PastebinClient {
  Future<Either<void, RequestError>> paste({
    @required final String pasteText,
    final PasteOptions options,
  });

  Future<Either<String, RequestError>> apiUserKey({
    @required final String username,
    @required final String password,
  });

  Future<Either<List<Paste>, RequestError>> pastes({
    final int limit = 50,
  });

  Future<Either<void, RequestError>> delete({
    @required final String pasteKey,
  });

  Future<Either<UserInfo, RequestError>> userInfo({
    @required final String userKey,
  });

  Future<Either<String, RequestError>> rawPaste({
    @required final String pasteKey,
    @required final Visibility visibility,
  });
}
