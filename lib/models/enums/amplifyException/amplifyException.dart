enum AMPLIFY_EXCEPTION { UserNotConfirmedException, NotAuthorizedException }

extension AmplifyExceptions on AMPLIFY_EXCEPTION {
  static const Map<AMPLIFY_EXCEPTION, int> values = {
    AMPLIFY_EXCEPTION.NotAuthorizedException: 1,
    AMPLIFY_EXCEPTION.UserNotConfirmedException: 2,
  };

  int? get value => values[this];
}
