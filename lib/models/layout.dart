import 'package:flutter/material.dart';

class LayoutConfig {
  final Color primaryColor, secondaryColor;
  LayoutConfig({@required this.primaryColor, @required this.secondaryColor});
}

class SidebarItem {
  final String title;
  final IconData icon;
  final Function function;
  SidebarItem(
      {@required this.title, @required this.icon, @required this.function});
}
