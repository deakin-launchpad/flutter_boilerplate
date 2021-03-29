import 'package:flutter/material.dart';
import 'package:user_onboarding/providers/providers.dart';
import '../../widgets/widgets.dart';

class DevEnvironment extends StatelessWidget {
  static final String route = '/dev';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Tools'),
      ),
      body: ListView(
        children: [
          DevEnvironmentListTile(
            title: 'Logout',
            onPressed: () {
              Provider.of<UserDataProvider>(context).logout(context);
            },
          ),
        ],
      ),
    );
  }
}
