import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/layout.dart';
import '../configurations/configurations.dart';

class ApplicationTheme {
  ThemeData _theme;

  ApplicationTheme() {
    final LayoutConfig _layoutConfig = Configurations().layoutConfig;
    _theme = ThemeData.light().copyWith(
      primaryColor: _layoutConfig.primaryColor,
      accentColor: _layoutConfig.secondaryColor,
      appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 1,
        color: _layoutConfig.primaryColor,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        textTheme: new TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      primaryTextTheme: TextTheme(
        headline6: ThemeData.light().primaryTextTheme.headline6.copyWith(
              color: Colors.black,
            ),
      ),
    );
  }

  ThemeData get getAppTheme => _theme;
}
