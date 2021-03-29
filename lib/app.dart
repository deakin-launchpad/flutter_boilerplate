import 'package:flutter/material.dart';

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
                  builder: (_, apiResponse) {
                    if (apiResponse.connectionState == ConnectionState.waiting)
                      return Scaffold(
                        body: Text('Loading..'),
                      );
                    else if (apiResponse.data == true) {
                      if (data.firstSignIn == null)
                        return Scaffold(
                          body: Text('Loading..'),
                        );
                      if (data.firstSignIn == true) return ChangePassword();
                      return Home();
                    } else
                      return WelcomePage();
                  },
                ),
          title: Constants.applicationConstants.title,
          theme: ApplicationTheme(context).getAppTheme,
          routes: Routes().base,
        ),
      ),
    );
  }
}
