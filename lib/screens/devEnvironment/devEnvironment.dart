import 'package:flutter/material.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class DevEnvironment extends StatelessWidget {
  static const String route = '/dev';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Tools'),
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
