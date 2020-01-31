import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget body, appBarActions;
  final Color backgroundColor;
  final Key key;
  final String appBarTitle;
  AdaptiveScaffold({
    this.key,
    @required this.body,
    @required this.appBarTitle,
    this.backgroundColor,
    this.appBarActions,
  });
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            key: key,
            child: SafeArea(
              child: body,
            ),
            navigationBar: CupertinoNavigationBar(
              middle: Text(appBarTitle),
              trailing: appBarActions,
            ),
            backgroundColor: backgroundColor,
          )
        : Scaffold(
            key: key,
            body: SafeArea(
              child: body,
            ),
            appBar: AppBar(
              title: Text(appBarTitle),
              actions: [appBarActions],
            ),
            backgroundColor: backgroundColor,
          );
  }
}
