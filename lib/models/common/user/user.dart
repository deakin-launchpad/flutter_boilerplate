import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceInfo {
  String? _deviceName, _deviceUUID, _deviceType;
  DeviceInfoPlugin _infoplugin = new DeviceInfoPlugin();
  DeviceInfo();

  Future<Map<String, String>> get toJSON async {
    if (kIsWeb) {
      debugPrint('inside web');
      _deviceType = 'WEB';
      WebBrowserInfo _info = await _infoplugin.webBrowserInfo;
      _deviceName = '${_info.browserName} on ${_info.platform}';

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      void updateWebUUID() {
        _deviceUUID = Uuid().v4();
        if (_deviceUUID != null) _prefs.setString('uuid', _deviceUUID!);
      }

      if (_prefs.containsKey('uuid')) {
        String _temp = _prefs.getString('uuid')!;
        if (_temp.isEmpty)
          updateWebUUID();
        else
          _deviceUUID = _temp;
      } else
        updateWebUUID();
    } else if (Platform.isIOS) {
      _deviceType = 'IOS';
      IosDeviceInfo info = await _infoplugin.iosInfo;
      _deviceName = '${info.name!.split(".").last} on ${info.systemVersion}';
      _deviceUUID = info.identifierForVendor!;
    } else if (Platform.isAndroid) {
      _deviceType = 'ANDROID';
      AndroidDeviceInfo info = await _infoplugin.androidInfo;
      _deviceName = '${info.manufacturer} ${info.model} on ${info.version}';
      _deviceUUID = info.androidId!;
    }

    return {
      'deviceName': this._deviceName!,
      'deviceType': this._deviceType!,
      'deviceUUID': this._deviceUUID!,
    };
  }
}

class UserLoginDetails {
  String? username;
  String? password;
  UserLoginDetails({this.username, this.password});

  Future<Map<String, dynamic?>> get toLoginApiJSON async {
    DeviceInfo info = new DeviceInfo();
    var deviceData = await info.toJSON;
    return {
      "emailId": this.username,
      "password": this.password,
      'deviceData': deviceData
    };
  }
}
