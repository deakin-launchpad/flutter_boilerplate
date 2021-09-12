import 'package:flutter/material.dart';
import '../providers/providers.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class LoginRouter extends StatefulWidget {
  @override
  _LoginRouterState createState() => _LoginRouterState();
}

class _LoginRouterState extends State<LoginRouter> {
  @override
  void initState() {
    Provider.of<UserDataProvider>(context, listen: false)
        .accessTokenLogin()
        .then((value) {
      if (value) {
        Provider.of<UserDataProvider>(context, listen: false).getUserProfile();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, userData, widget) {
        if (userData.loginStatus == false) return const WelcomePage();
        if (userData.userProfile == null) return const LoadingScreen('');
        if (userData.userProfile!.firstLogin == false) return ChangePassword();
        return Home();
      },
    );
  }
}
