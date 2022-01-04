import 'package:flutter/material.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import 'providers/providers.dart';
import 'constants/constants.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';
import 'helpers/helpers.dart';
import 'widgets/widgets.dart';

class Application extends StatefulWidget {
  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  Routes routerInstance = Routes();
  bool _check = false;

  Future<void> _configureAmplify() async {
    Constants _constants = Constants();

    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(_constants.amplifyConfiguration);
    } catch (error) {
      logger.wtf(error.toString());
    } finally {
      if (Amplify.isConfigured) {
        setState(() {
          _check = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    routerInstance.configureRoutes();
    _configureAmplify();
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
        home: _check ? LoginRouter() : const LoadingScreen("Configuring..."),
        title: Constants.applicationConstants.title,
        theme: ApplicationTheme(context).getAppTheme,
        onGenerateRoute: routerInstance.router.generator,
      ),
    );
  }
}
