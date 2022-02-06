import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';
import '../../providers/providers.dart';

class Home extends StatelessWidget {
  static const String route = '/home';
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
          child: FutureBuilder(
            future: SharedPrefHelper.accessToken,
            builder: (_, AsyncSnapshot<String?> accessToken) => Center(
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      accessToken.data != null
                          ? 'accessToken: ${accessToken.data}'
                          : 'Empty',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
