// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../helpers/helpers.dart';
import '../constants/constants.dart';

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
    DIOResponseBody response = Constants.amplifyEnabled
        ? await AmplifyAuth.accessTokenLogin(localToken)
        : await API().accessTokenLogin(localToken);
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
  Future<void> assignAccessToken(String token) async {
    if (token != "") {
      _accessToken = token;
      _userLoggedIn = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loginStatus', true);
      await prefs.setString('accessToken', token);
      notifyListeners();
    }
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
    if (Constants.amplifyEnabled) {
      await AmplifyAuth.logout();
      _userLoggedIn = false;
      _accessToken = null;
      final prefs = await SharedPreferences.getInstance();
      if (await prefs.clear()) {
        if (context.mounted) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      }
    } else {
      var _accessToken = await SharedPrefHelper.accessToken;
      bool response = await API().logout(_accessToken!);
      if (response || accessToken == null) {
        _userLoggedIn = false;
        _accessToken = null;
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/welcome', (route) => route.isFirst);
        }
      }
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
