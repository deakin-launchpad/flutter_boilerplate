import 'package:flutter/cupertino.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../../models/models.dart';
import '../../helpers/helpers.dart';

class AmplifyAuth {
  static final AmplifyAuth auth = AmplifyAuth._privateConstructor();

  AmplifyAuth._privateConstructor() {
    debugPrint("All Auth services initialized.");
  }

  factory AmplifyAuth() {
    return auth;
  }

  static Future<bool> get loginStatus async {
    try {
      AuthSession session = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true));
      logger.i("Auth isLoggedIn: ${session.isSignedIn}");
      return session.isSignedIn;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  static Future<String?> get accessToken async {
    try {
      AuthSession session = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true));
      if (session.isSignedIn == false) {
        return '';
      }

      CognitoAuthSession authSession = (session as CognitoAuthSession);
      AWSCognitoUserPoolTokens? userToken = authSession.userPoolTokens;

      if (userToken == null) {
        return '';
      }
      return userToken.idToken;
    } catch (e) {
      return '';
    }
  }

  static Future<DIOResponseBody> amplifyUserLogin(LoginAPIBody details) async {
    try {
      CognitoSignInResult loginResult = await Amplify.Auth.signIn(
              username: details.username!,
              password: details.password!,
              options: CognitoSignInOptions(clientMetadata: {}))
          as CognitoSignInResult;

      // Check api data returned.
      // logger.i("Step: ", _loginResult.nextStep!.signInStep);
      // logger.i("Additional Info", _loginResult.nextStep!.additionalInfo);
      // logger.i("Code Deli Details", _loginResult.nextStep!.codeDeliveryDetails);

      if (loginResult.isSignedIn) {
        return DIOResponseBody(success: true, data: loginResult.isSignedIn);
      } else {
        return DIOResponseBody(success: false, data: "Login Failed");
      }
    } on NotAuthorizedException catch (err) {
      logger.e(err);
      return DIOResponseBody(success: false, data: err);
    } on UserNotConfirmedException {
      return DIOResponseBody(
          success: false, data: AMPLIFY_EXCEPTION.UserNotConfirmedException);
    } catch (err) {
      return DIOResponseBody(success: false, data: err);
    }
  }

  static Future<DIOResponseBody> accessTokenLogin(String accessToken) async {
    CognitoAuthSession session = await Amplify.Auth.fetchAuthSession(
            options: CognitoSessionOptions(getAWSCredentials: true))
        as CognitoAuthSession;
    if (session.isSignedIn) {
      return DIOResponseBody(success: true);
    } else {
      return DIOResponseBody(success: false);
    }
  }

  static Future<DIOResponseBody> amplifyRegisterUser(userDetails) async {
    try {
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.email: userDetails["emailId"],
        CognitoUserAttributeKey.givenName: userDetails["firstName"],
        CognitoUserAttributeKey.familyName: userDetails["lastName"],
        CognitoUserAttributeKey.phoneNumber:
            userDetails["countryCode"] + userDetails["phoneNumber"],
      };
      CognitoSignUpResult signupResult = await Amplify.Auth.signUp(
              username: userDetails['emailId']!,
              password: userDetails['password']!,
              options: CognitoSignUpOptions(userAttributes: userAttributes))
          as CognitoSignUpResult;

      if (signupResult.isSignUpComplete) {
        return DIOResponseBody(success: true);
      } else {
        return DIOResponseBody(success: false, data: "SignUp Failed");
      }
    } on NotAuthorizedException catch (err) {
      logger.e(err);
      return DIOResponseBody(success: false, data: err.message);
    }
  }

  static Future<DIOResponseBody> amplifyConfirmSignUp(
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

  static Future<void> logout() async {
    await Amplify.Auth.signOut();
    return;
  }
}
