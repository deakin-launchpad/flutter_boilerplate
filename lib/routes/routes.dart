import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_onboarding/widgets/common/common.dart';

import '../screens/screens.dart';
export './loginRouter.dart';

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
