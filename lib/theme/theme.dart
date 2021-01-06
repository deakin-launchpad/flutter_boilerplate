import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/layout.dart';
import '../configurations/configurations.dart';

class ApplicationTheme {
  ThemeData _theme;

  ApplicationTheme(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
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
        textTheme: GoogleFonts.latoTextTheme(_textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: _textTheme.bodyText1),
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
