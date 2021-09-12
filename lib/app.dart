import 'package:flutter/material.dart';

import 'providers/providers.dart';
import 'constants/constants.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class Application extends StatefulWidget {
  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  Routes routerInstance = Routes();

  @override
  void initState() {
    super.initState();
    routerInstance.configureRoutes();
  }

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
        onGenerateRoute: routerInstance.router.generator,
      ),
    );
  }
}
