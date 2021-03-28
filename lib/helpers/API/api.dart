import 'package:dio/dio.dart';

import '../../models/models.dart';
import './dioInstance.dart';

class API {
  static final API api = API._privateConstructor();
  final DioInstance _dioInstance = new DioInstance();

  API._privateConstructor() {
    print("All APIs initialized.");
  }

  factory API() {
    return api;
  }

  DIOResponseBody errorHelper(error) {
    if (error == null)
      return DIOResponseBody(success: false, data: 'Network Error');
    if (error.response == null)
      return DIOResponseBody(success: false, data: "Network Error");
    if (error.response == null)
      return DIOResponseBody(
          success: false, data: 'Connection to Backend Failed');
    if (error.response.data["message"] != null)
      return DIOResponseBody(
          success: false, data: error.response.data["message"]);
    return DIOResponseBody(success: false, data: "Oops! Something went wrong!");
  }

  Future<DIOResponseBody> userLogin(UserLoginDetails details) async {
    return _dioInstance.instance
        .post('user/login', data: await details.toLoginApiJSON)
        .then((respone) {
      return DIOResponseBody(
          success: true, data: respone.data['data']['accessToken']);
    }).catchError((error) {
      return _dioInstance.errorHelper(error);
    });
  }

  Future<bool> accessTokenLogin(accessToken) async {
    return _dioInstance.instance
        .post('user/accessTokenLogin',
            options:
                Options(headers: {'authorization': 'Bearer ' + accessToken}))
        .then((respone) {
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> registerUser(userDetails) async {
    return _dioInstance.instance
        .post('user/register', data: userDetails)
        .then((respone) {
      return true;
    }).catchError((error) {
      print(error.response);
      return false;
    });
  }
}
