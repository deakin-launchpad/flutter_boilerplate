import 'package:flutter/material.dart';

class SidebarItem {
  final String title;
  final IconData icon;
  final Function fun;
  SidebarItem({@required this.title, @required this.icon, @required this.fun});
}

class _LayoutConfig {
  final Color primaryColor, secondaryColor;
  _LayoutConfig({@required this.primaryColor, @required this.secondaryColor});
}

class Configurations {
  final String _appTitle = "useronboarding";
  final String _backendUrl = "http://localhost:8041";
  final bool _bypassbackend = true;
  var layoutConfig =
      _LayoutConfig(primaryColor: Colors.indigo, secondaryColor: Colors.yellow);

  final List<SidebarItem> sideBarItems = [];
  String get backendUrl {
    return _backendUrl;
  }

  String get appTitle {
    return _appTitle;
  }

  bool get bypassBackend {
    return _bypassbackend;
  }
}
