import '../../common/deviceInfo/deviceInfo.dart';

class LoginAPIBody {
  String? username;
  String? password;
  LoginAPIBody({this.username, this.password});

  Future<Map<String, dynamic>> get toLoginApiJSON async {
    DeviceInfo _plugin = DeviceInfo();
    Map<String, String> deviceData = await _plugin.info;
    return {
      "emailId": username,
      "password": password,
      'deviceData': deviceData
    };
  }
}
