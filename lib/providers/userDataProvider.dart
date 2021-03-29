import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../helpers/helpers.dart';

class UserDataProvider with ChangeNotifier {
  String? _accessToken;
  bool _userLoggedIn = false;
  bool? _firstSignIn;
  UserProfileAPIBody? _userProfile;

  Future<bool> accessTokenLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('accessToken')) return false;
    var localToken = prefs.getString('accessToken')!;
    DIOResponseBody response = await API().accessTokenLogin(localToken);
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

  String? get accessToken {
    if (_accessToken == null) return "";
    return _accessToken;
  }

  bool get loginStatus => _userLoggedIn;

  bool? get firstSignIn => _firstSignIn;

  UserProfileAPIBody? get userProfile => _userProfile;

  void assignAccessToken(String token) async {
    if (token != "") {
      _accessToken = token;
      _userLoggedIn = true;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', token);
      prefs.setBool('loginStatus', true);
      notifyListeners();
    }
  }

  void changeFirstLoginStatus(bool status) async {
    _firstSignIn = status;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstSignIn', status);
    notifyListeners();
  }

  void logout(BuildContext context) async {
    bool response = await API().logout(_accessToken!);
    if (response || accessToken == null) {
      _userLoggedIn = false;
      notifyListeners();
      _accessToken = null;
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushNamedAndRemoveUntil(
          context, '/welcome', (route) => route.isFirst);
    }
  }

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
