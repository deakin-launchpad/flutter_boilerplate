import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    if (!prefs.containsKey('accessToken')) return '';
    String? token = prefs.getString('accessToken');
    return token ?? '';
  }

  Handler unAuthenticatedRoute(Widget screen) {
    return Handler(
      handlerFunc: (context, params) {
        return FutureBuilder(
          future:
              Constants.amplifyEnabled ? AmplifyAuth.accessToken : accessToken,
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
          future:
              Constants.amplifyEnabled ? AmplifyAuth.accessToken : accessToken,
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
