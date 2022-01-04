import 'application.dart';
import 'connection.dart';
import 'amplifyconfiguration.dart';

import '../models/models.dart';

class Constants {
  static ApplicationConstants applicationConstants = ApplicationConstants();
  static ConnectionConstants connectionConstants = ConnectionConstants();
  static const String OTP_GIF_IMAGE = "lib/assets/img/logo/otp.gif";
  static const bool devBuild = true;
  static const bool debugBanner = false;
  static const bool bypassBackend = false;
  static const String devAccessToken = '';
  static final LoginAPIBody devUser = LoginAPIBody(
    username: 'user@launchpad.com',
    password: 'password',
  );

  String get amplifyConfiguration => amplifyconfig;
}
