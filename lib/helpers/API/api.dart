import '../../models/models.dart';
import 'package:dio/dio.dart';
import './dioInstance.dart';

class API {
  final Dio _dioinstance = DioInstance().construct;

  DIOResponseBody errorHelper(error) {
    if (error.response.isEmpty) {
      return DIOResponseBody(success: false, data: "Network Error");
    }
    return DIOResponseBody(
        success: false, data: error.response.data['message']);
  }

  Future<DIOResponseBody> userLogin(details) async {
    return _dioinstance.post('user/login', data: details).then((respone) {
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
