import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../helpers/helpers.dart';

class UserDataProvider with ChangeNotifier {
  String? _accessToken;
  bool _userLoggedIn = false;
  bool? _firstSignIn;
  UserProfileAPIBody? _userProfile;

  /// login using the accessToken from SharedPrefences
  Future<bool> accessTokenLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('accessToken')) return false;
    var localToken = prefs.getString('accessToken')!;
    DIOResponseBody response = await AmplifyAuth().accessTokenLogin(localToken);
    if (response.success) {
      _userLoggedIn = true;
      _accessToken = localToken;
      _firstSignIn = !response.data['userDetails']['firstLogin'];
      return true;
    } else {
      _userLoggedIn = false;
      _accessToken = "";
      return false;
    }
  }

  /// return the accessToken [accessToken]
  String? get accessToken {
    if (_accessToken == null) return "";
    return _accessToken;
  }

  void refresh() {
    notifyListeners();
  }

  /// returns current [loginStatus]
  bool get loginStatus => _userLoggedIn;

  /// return [firstSignIn] status
  bool? get firstSignIn => _firstSignIn;

  /// returns current [userProfile]
  UserProfileAPIBody? get userProfile => _userProfile;

  /// update current accessToken and store in SharePrefs with [token]
  Future<bool> assignAccessToken(String token) async {
    if (token != "") {
      _accessToken = token;
      _userLoggedIn = true;
      final prefs = await SharedPreferences.getInstance();
      final loginStatusSet = await prefs.setBool('loginStatus', true);
      final accessTokenSet = await prefs.setString('accessToken', token);
      return (loginStatusSet && accessTokenSet);
    }
    return false;
  }

  /// update first login status
  void changeFirstLoginStatus(bool status) async {
    _firstSignIn = status;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstSignIn', status);
    notifyListeners();
  }

  /// log user out
  void logout(BuildContext context) async {
    await AmplifyAuth().logout();
    _userLoggedIn = false;
    _accessToken = null;
    final prefs = await SharedPreferences.getInstance();
    if (await prefs.clear()) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/welcome', (route) => route.isFirst);
    }
  }

  /// update login status with [status]
  void changeLoginStatus(bool status) {
    _userLoggedIn = status;
    notifyListeners();
  }

  Future<UserProfileAPIBody?> getUserProfile() async {
    DIOResponseBody response = await API().getProfile();
    if (response.success) {
      _userProfile = UserProfileAPIBody.fromJson(response.data);
    }
    notifyListeners();
    return _userProfile;
  }
}
