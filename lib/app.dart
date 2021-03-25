import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';

import 'constants/constants.dart';
import 'screens/screens.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserDataProvider(),
        ),
      ],
      child: Consumer<UserDataProvider>(
        builder: (_, data, __) => MaterialApp(
          debugShowCheckedModeBanner: Constants.debugBanner,
          home: data.loginStatus
              ? Home()
              : FutureBuilder(
                  future: data.accessTokenLogin(),
                  builder: (_, result) =>
                      result.connectionState == ConnectionState.waiting
                          ? Scaffold(
                              body: Text('Loading..'),
                            )
                          : WelcomePage(),
                ),
          title: Constants.applicationConstants.title,
          theme: ApplicationTheme(context).getAppTheme,
          routes: Routes().base,
        ),
      ),
    );
  }
}
