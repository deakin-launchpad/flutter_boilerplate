import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import '../providers/providers.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import '../helpers/helpers.dart';

class LoginRouter extends StatefulWidget {
  @override
  _LoginRouterState createState() => _LoginRouterState();
}

class _LoginRouterState extends State<LoginRouter> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      ).catchError((error) {
        logger.e(error);
      }),
      builder: (context, AsyncSnapshot<AuthSession> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen('');
        }
        if (snapshot.data == null) {
          return const WelcomePage();
        }
        if (snapshot.data!.isSignedIn == false) {
          return const WelcomePage();
        }

        logger.i('User is signed in');

        CognitoAuthSession _session = (snapshot.data! as CognitoAuthSession);
        AWSCognitoUserPoolTokens? _userToken = _session.userPoolTokens;

        if (_userToken == null) {
          return const WelcomePage();
        }

        Amplify.Auth.fetchUserAttributes()
            .then((List<AuthUserAttribute> attributes) {
          for (AuthUserAttribute attribute in attributes) {
            logger.d("${attribute.userAttributeKey} : ${attribute.value}");
          }
        }).catchError((error) {
          logger.e(error);
        });

        return FutureBuilder(
          future: Provider.of<UserDataProvider>(context)
              .assignAccessToken(_userToken.idToken),
          builder: (context, AsyncSnapshot<bool> status) {
            if (status.connectionState == ConnectionState.waiting) {
              return const LoadingScreen('Loading...');
            }
            if (!status.hasData) {
              return const WelcomePage();
            }
            logger.i("Token assigned: ", status.data);
            if (status.data == false) {
              return const WelcomePage();
            }
            return Home();
          },
        );
      },
    );
  }
}
