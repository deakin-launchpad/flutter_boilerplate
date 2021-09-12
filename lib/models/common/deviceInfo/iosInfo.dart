import 'package:device_info_plus/device_info_plus.dart';

class IosInfo {
  final DeviceInfoPlugin _plugin = DeviceInfoPlugin();
  String uuid;
  IosInfo({required this.uuid});
  Future<Map<String, String>> get info async {
    IosDeviceInfo _info = await _plugin.iosInfo;
    return {
      'deviceName': '${_info.name} on ${_info.systemVersion}',
      'deviceUUID': uuid,
      'deviceType': 'IOS'
    };
  }
}
