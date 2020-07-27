import 'package:dio/dio.dart';

import '../../models/models.dart';
import './dioInstance.dart';

class API {
  static final API api = API._privateConstructor();
  final Dio _dioinstance = DioInstance().instance;

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
    return _dioinstance
        .post('user/login', data: details.toLoginApiJSON)
        .then((respone) {
      return DIOResponseBody(
          success: true, data: respone.data['data']['accessToken']);
    }).catchError((error) {
      return DIOResponseBody(
          success: false, data: error.response.data['message']);
    });
  }

  Future<bool> accessTokenLogin(accessToken) async {
    return _dioinstance
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
    return _dioinstance
        .post('user/register', data: userDetails)
        .then((respone) {
      return true;
    }).catchError((error) {
      print(error.response);
      return false;
    });
  }
}
