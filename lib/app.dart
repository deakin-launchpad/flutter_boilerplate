import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/screens.dart';

import './providers/providers.dart';
import 'configurations/configurations.dart';
import './routes/routes.dart';
import './theme/theme.dart';

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
          debugShowCheckedModeBanner: Configurations.debugBanner,
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
          title: Configurations().appTitle,
          theme: ApplicationTheme(context).getAppTheme,
          routes: Routes().base,
        ),
      ),
    );
  }
}
