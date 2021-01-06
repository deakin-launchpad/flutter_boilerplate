import 'package:flutter/material.dart';

import '../screens/screens.dart';

class Routes {
  Map<String, WidgetBuilder> base = {
    WelcomePage.route: (ctx) => WelcomePage(),
    '/login': (ctx) => Login(),
    '/home': (ctx) => Home(),
    SignUp.route: (ctx) => SignUp()
  };

  Widget landingPage = Home();
}
