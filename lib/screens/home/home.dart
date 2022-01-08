import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

import '../../providers/providers.dart';

class Home extends StatelessWidget {
  static const String route = '/home';
  FlutterAppAuth appAuth = FlutterAppAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User OnBoarding'),
          actions: <Widget>[
            GestureDetector(
                onTap: () {},
                child: Consumer<UserDataProvider>(
                    builder: (context, data, __) => TextButton(
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            data.logout(context);
                          },
                        )))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Consumer<UserDataProvider>(
            builder: (_, data, __) => Center(
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      data.accessToken != null
                          ? 'accessToken: ${data.accessToken}'
                          : 'Empty',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // AuthorizationRequest request = AuthorizationRequest(clientId, redirectUrl)
                        // appAuth.authorize(request);
                      },
                      child: const Text("OAuth 2.0"))
                ],
              ),
            ),
          ),
        ));
  }
}
