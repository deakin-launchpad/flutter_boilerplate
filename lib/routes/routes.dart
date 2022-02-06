import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../constants/constants.dart';
import '../helpers/helpers.dart';
import '../widgets/widgets.dart';
import '../screens/screens.dart';

class Routes {
  static final FluroRouter _router = FluroRouter();

  Routes() {
    _router.notFoundHandler = Handler(handlerFunc: (context, params) {
      return const Scaffold(
        body: Center(
          child: Text('404'),
        ),
      );
    });
  }

  Future<String> get accessToken async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('accessToken')) {
      if (!Constants.amplifyEnabled) return '';
      try {
        AuthSession _session = await Amplify.Auth.fetchAuthSession(
            options: CognitoSessionOptions(getAWSCredentials: true));
        if (_session.isSignedIn == false) {
          return '';
        }

        CognitoAuthSession _authSession = (_session as CognitoAuthSession);
        AWSCognitoUserPoolTokens? _userToken = _authSession.userPoolTokens;

        if (_userToken == null) {
          return '';
        }

        prefs.setString('accessToken', _userToken.idToken);
      } catch (e) {
        return '';
      }
    }
    var token = prefs.getString('accessToken');
    return token ?? '';
  }

  Handler unAuthenticatedRoute(Widget screen) {
    return Handler(
      handlerFunc: (context, params) {
        return FutureBuilder(
          future: accessToken,
          builder: (context, tokenSnapshot) {
            if (tokenSnapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen('');
            }
            if (tokenSnapshot.data == '') return screen;
            logger.i(tokenSnapshot.data);
            return Home();
          },
        );
      },
    );
  }

  Handler authenicatedRoute(Widget screen) {
    return Handler(
      handlerFunc: (context, params) {
        return FutureBuilder(
          future: accessToken,
          builder: (context, tokenSnapshot) {
            if (tokenSnapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen('');
            }
            if (tokenSnapshot.data == '') return const WelcomePage();
            return screen;
          },
        );
      },
    );
  }

  Handler confirmAccountRoute() {
    return Handler(handlerFunc: (context, params) {
      return ConfirmAccount(
        email: params['email']![0],
        password: params['password']![0],
      );
    });
  }

  void _defineRoute(String route, Handler handler,
      {transitionType = TransitionType.material}) {
    _router.define(route, handler: handler, transitionType: transitionType);
  }

  void configureRoutes() {
    _defineRoute(
      WelcomePage.route,
      unAuthenticatedRoute(const WelcomePage()),
    );
    _defineRoute(
      Login.route,
      unAuthenticatedRoute(Login()),
    );
    _defineRoute(
      SignUp.route,
      unAuthenticatedRoute(SignUp()),
    );
    _defineRoute(
      ConfirmAccount.route,
      confirmAccountRoute(),
    );
    _defineRoute(
      Home.route,
      authenicatedRoute(Home()),
    );
    _defineRoute(
      ChangePassword.route,
      authenicatedRoute(ChangePassword()),
    );
    _defineRoute(
      DevEnvironment.route,
      authenicatedRoute(DevEnvironment()),
    );
  }

  FluroRouter get router => _router;
}
