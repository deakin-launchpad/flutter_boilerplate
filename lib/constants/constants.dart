import '../models/models.dart';
import 'application.dart';
import 'connection.dart';

class Constants {
  static ApplicationConstants applicationConstants = ApplicationConstants();
  static ConnectionConstants connectionConstants = ConnectionConstants();
  static const bool devBuild = true;
  static const bool debugBanner = false;
  static const bool bypassBackend = false;
  static const String devAccessToken = '';
  static final UserLoginDetails devUser = UserLoginDetails(
    username: 'user@launchpad.com',
    password: 'password',
  );
}
