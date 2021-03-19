import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LayoutHelper {
  static final LayoutHelper _instance = LayoutHelper._privateConstructor();
  LayoutHelper._privateConstructor() {
    debugPrint("LayoutHelper initilised.");
  }
  factory LayoutHelper() => _instance;

  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide > 600;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide > 600 &&
      MediaQuery.of(context).size.shortestSide > 1200;

  bool get isWeb => kIsWeb;
}
