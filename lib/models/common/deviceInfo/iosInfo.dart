import 'package:device_info/device_info.dart';

class IosInfo {
  DeviceInfoPlugin _plugin = new DeviceInfoPlugin();
  Future<Map<String, String>> get info async {
    IosDeviceInfo _info = await _plugin.iosInfo;
    return {
      'deviceName': '${_info.name} on ${_info.systemVersion}',
      'deviceUUID': _info.identifierForVendor,
      'deviceType': 'IOS'
    };
  }
}
