import '../deviceInfo/deviceInfo.dart';

class UserLoginDetails {
  String? username;
  String? password;
  UserLoginDetails({this.username, this.password});

  Future<Map<String, dynamic?>> get toLoginApiJSON async {
    DeviceInfo _plugin = new DeviceInfo();
    Map<String, String> deviceData = await _plugin.info;
    return {
      "emailId": this.username,
      "password": this.password,
      'deviceData': deviceData
    };
  }
}
