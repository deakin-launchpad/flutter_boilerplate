import 'package:flutter/material.dart';
import 'package:user_onboarding/models/dependants/dependants.dart';

import 'widgets/widgets.dart';
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
                      return LoadingScreen(
                          Constants.applicationConstants.title);
                    else if (apiResponse.data == true) {
                      return FutureBuilder(
                        future: data.getUserProfile(),
                        builder: (context, apiResponse) {
                          if (apiResponse.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingScreen(
                                Constants.applicationConstants.title);
                          }
                          if (apiResponse.hasError)
                            return LoadingScreen(apiResponse.error.toString());

                          if (apiResponse.data != null) if ((apiResponse.data
                                      as UserProfileAPIBody)
                                  .firstLogin ==
                              false) return ChangePassword();
                          return Home();
                        },
                      );
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
