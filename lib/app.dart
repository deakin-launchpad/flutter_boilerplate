import 'package:flutter/material.dart';

import 'providers/providers.dart';
import 'constants/constants.dart';
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
      child: MaterialApp(
        debugShowCheckedModeBanner: Constants.debugBanner,
        home: LoginRouter(),
        title: Constants.applicationConstants.title,
        theme: ApplicationTheme(context).getAppTheme,
        routes: Routes().base,
      ),
    );
  }
}
