import 'package:flutter/material.dart';
import '../models/models.dart';

class Configurations {
  static final bool devBuild = true;

  final bool _bypassbackend = true;

  final String _appTitle = "useronboarding";
  final String _backendUrl = "http://localhost:8041";

  final UserLoginDetails _devDetails = new UserLoginDetails(
    username: "developer@dev.dev",
    password: "secretpassword",
  );

  LayoutConfig layoutConfig =
      LayoutConfig(primaryColor: Colors.indigo, secondaryColor: Colors.yellow);

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

  UserLoginDetails getDevDetails() {
    return _devDetails;
  }
}
