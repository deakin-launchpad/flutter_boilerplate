import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../models/models.dart';

class LayoutHelper {
  static final LayoutHelper _instance = LayoutHelper._privateConstructor();
  LayoutHelper._privateConstructor() {
    debugPrint("LayoutHelper initilised.");
  }
  factory LayoutHelper() => _instance;

  bool get isWeb => kIsWeb;

  ScreenSize getScreenSize(BuildContext context) {
    if (MediaQuery.of(context).size.shortestSide < 400) return ScreenSize.XS;
    if (MediaQuery.of(context).size.shortestSide < 600) return ScreenSize.SM;
    if (MediaQuery.of(context).size.shortestSide < 786) return ScreenSize.MD;
    if (MediaQuery.of(context).size.shortestSide < 1200) return ScreenSize.LG;
    return ScreenSize.XL;
  }

  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide > 700;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide > 1200;
}
