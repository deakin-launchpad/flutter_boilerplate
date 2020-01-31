import 'package:flutter/material.dart';
import '../configurations/configurations.dart';

ThemeData applicationTheme=ThemeData(
  primarySwatch: Configurations().layoutConfig.primaryColor,
  accentColor: Configurations().layoutConfig.secondaryColor
);