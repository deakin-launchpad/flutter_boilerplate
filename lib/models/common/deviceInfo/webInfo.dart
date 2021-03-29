import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class WebInfo {
  DeviceInfoPlugin _infoplugin = new DeviceInfoPlugin();

  Future<Map<String, String>> get info async {
    String? _deviceUUID;
    WebBrowserInfo _info = await _infoplugin.webBrowserInfo;

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
    return {
      'deviceUUID': _deviceUUID!,
      'deviceType': 'WEB',
      'deviceName':
          '${_info.browserName.toString().split(".").last} on ${_info.platform}',
    };
  }
}
