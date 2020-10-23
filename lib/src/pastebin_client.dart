import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'models/models.dart';

abstract class PastebinClient {
  Either<void, RequestError> paste({
    @required final String pasteText,
    final PasteOptions options,
  });

  Either<String, RequestError> apiUserKey({
    @required final String username,
    @required final String password,
  });

  Either<List<Paste>, RequestError> pastes({
    final int limit = 50,
  });

  Either<void, RequestError> delete({
    @required final String pasteKey,
  });

  Either<UserInfo, RequestError> userInfo({
    @required final String userKey,
  });

  Either<String, RequestError> rawPaste({
    @required final String pasteKey,
    @required final Visibility visibility,
  });
}
