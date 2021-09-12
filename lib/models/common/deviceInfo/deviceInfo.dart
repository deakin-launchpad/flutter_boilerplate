import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'androidInfo.dart';
import 'webInfo.dart';
import 'iosInfo.dart';

class DeviceInfo {
  Future<String> generateUUID() async {
    String? _deviceUUID;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    void updateWebUUID() {
      _deviceUUID = const Uuid().v4();
      if (_deviceUUID != null) _prefs.setString('uuid', _deviceUUID!);
    }

    if (_prefs.containsKey('uuid')) {
      String _temp = _prefs.getString('uuid')!;
      if (_temp.isEmpty) {
        updateWebUUID();
      } else {
        _deviceUUID = _temp;
      }
    } else {
      updateWebUUID();
    }
    return _deviceUUID!;
  }

  Future<Map<String, String>> get info async {
    String uuid = await generateUUID();
    if (kIsWeb) {
      return await WebInfo(uuid: uuid).info;
    } else if (Platform.isIOS) {
      return await IosInfo(uuid: uuid).info;
    } else if (Platform.isAndroid) {
      return await AndroidInfo(uuid: uuid).info;
    }
    return {};
  }
}
