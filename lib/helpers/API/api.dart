import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import '../../models/models.dart';
import './dioInstance.dart';
import '../../helpers/helpers.dart';

class API {
  static final API api = API._privateConstructor();
  final DioInstance _dioInstance = DioInstance();

  API._privateConstructor() {
    debugPrint("All APIs initialized.");
  }

  factory API() {
    return api;
  }

  Future<DIOResponseBody> amplifyUserLogin(LoginAPIBody details) async {
    try {
      CognitoSignInResult _loginResult = await Amplify.Auth.signIn(
              username: details.username!,
              password: details.password!,
              options: CognitoSignInOptions(clientMetadata: {}))
          as CognitoSignInResult;

      if (_loginResult.isSignedIn) {
        return DIOResponseBody(success: true);
      } else {
        return DIOResponseBody(success: false, data: "Login Failed");
      }
    } on NotAuthorizedException catch (err) {
      logger.e(err);
      return DIOResponseBody(
          success: false, data: AMPLIFY_EXCEPTION.NotAuthorizedException);
    } on UserNotConfirmedException catch (err) {
      logger.e(err);
      return DIOResponseBody(
          success: false, data: AMPLIFY_EXCEPTION.UserNotConfirmedException);
    } catch (err) {
      return DIOResponseBody(success: false, data: err);
    }
  }

  Future<DIOResponseBody> accessTokenLogin(String accessToken) async {
    CognitoAuthSession _session = await Amplify.Auth.fetchAuthSession(
            options: CognitoSessionOptions(getAWSCredentials: true))
        as CognitoAuthSession;
    if (_session.isSignedIn) {
      return DIOResponseBody(success: true);
    } else {
      return DIOResponseBody(success: false);
    }
  }

  Future<DIOResponseBody> amplifyRegisterUser(userDetails) async {
    try {
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.email: userDetails["emailId"],
        CognitoUserAttributeKey.givenName: userDetails["firstName"],
        CognitoUserAttributeKey.familyName: userDetails["lastName"],
        CognitoUserAttributeKey.phoneNumber:
            userDetails["countryCode"] + userDetails["phoneNumber"],
      };
      CognitoSignUpResult _signupResult = await Amplify.Auth.signUp(
              username: userDetails['emailId']!,
              password: userDetails['password']!,
              options: CognitoSignUpOptions(userAttributes: userAttributes))
          as CognitoSignUpResult;

      if (_signupResult.isSignUpComplete) {
        return DIOResponseBody(success: true);
      } else {
        return DIOResponseBody(success: false, data: "SignUp Failed");
      }
    } on NotAuthorizedException catch (err) {
      logger.e(err);
      return DIOResponseBody(success: false, data: err.message);
    }
  }

  Future<DIOResponseBody> amplifyConfirmSignUp(
      String username, String otp) async {
    try {
      SignUpResult result = await Amplify.Auth.confirmSignUp(
        username: username.trim(),
        confirmationCode: otp.trim(),
      );

      if (result.isSignUpComplete) {
        return DIOResponseBody(success: true);
      } else {
        return DIOResponseBody(success: false, data: "SignUp Failed");
      }
    } catch (err) {
      return DIOResponseBody(success: false, data: err);
    }
  }

  Future<void> logout() async {
    await Amplify.Auth.signOut();
    return;
  }

  Future<DIOResponseBody> changePassword(ChangePasswordAPIBody data) async {
    return _dioInstance.instance
        .put(
          'user/changePassword',
          data: data.toJSON(),
          options: Options(
            headers: {
              'authorization': 'Bearer ' + await _dioInstance.accessToken
            },
          ),
        )
        .then((response) => DIOResponseBody(
              success: true,
              data: response.data['data'],
            ))
        .catchError((onError) => _dioInstance.errorHelper(onError));
  }

  Future<DIOResponseBody> getProfile() async {
    return _dioInstance.instance
        .get(
          'user/getProfile',
          options: Options(
            headers: {
              'authorization': 'Bearer ' + await _dioInstance.accessToken
            },
          ),
        )
        .then((response) => DIOResponseBody(
            success: true, data: response.data['data']['customerData']))
        .catchError((onError) => _dioInstance.errorHelper(onError));
  }
}
