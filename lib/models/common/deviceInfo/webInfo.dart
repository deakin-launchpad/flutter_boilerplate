import 'package:device_info_plus/device_info_plus.dart';

class WebInfo {
  final DeviceInfoPlugin _infoplugin = DeviceInfoPlugin();
  String uuid;

  WebInfo({required this.uuid});

  Future<Map<String, String>> get info async {
    WebBrowserInfo _info = await _infoplugin.webBrowserInfo;

    return {
      'deviceUUID': uuid,
      'deviceType': 'WEB',
      'deviceName':
          '${_info.browserName.toString().split(".").last} on ${_info.platform}',
    };
  }
}
