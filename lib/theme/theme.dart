import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationTheme {
  ThemeData? _theme;

  ApplicationTheme(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    _theme = ThemeData.light().copyWith(
      primaryColor: Colors.white,
      accentColor: Colors.blueAccent,
      appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 1,
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        textTheme: GoogleFonts.latoTextTheme(_textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: _textTheme.bodyText1),
        ),
      ),
      primaryTextTheme: TextTheme(
        headline6: ThemeData.light().primaryTextTheme.headline6!.copyWith(
              color: Colors.black,
            ),
      ),
    );
  }

  ThemeData? get getAppTheme => _theme;
}
