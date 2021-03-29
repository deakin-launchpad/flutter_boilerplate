import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'androidInfo.dart';
import 'webInfo.dart';
import 'iosInfo.dart';

class DeviceInfo {
  Future<Map<String, String>> get info async {
    if (kIsWeb)
      return await WebInfo().info;
    else if (Platform.isIOS)
      return await IosInfo().info;
    else if (Platform.isAndroid) return await AndroidInfo().info;
    return {};
  }
}
