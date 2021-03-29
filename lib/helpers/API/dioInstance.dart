import 'package:dio/dio.dart';

import '../../models/models.dart';
import '../../constants/constants.dart';
import "../../helpers/helpers.dart";

class DioInstance {
  final Dio _instance = new Dio();
  final String _baseUrl = Constants.connectionConstants.backendUrl + '/api/';
  final int _connectionTimeout = 5000;
  final int _receiveTimeout = 3000;

  DioInstance() {
    if (Constants.devBuild == true)
      _instance.interceptors.add(LogInterceptor(responseBody: true));
    _instance.options.baseUrl = _baseUrl;
    logger.i('DIO instance Constructed\nBase Url: ' + _baseUrl.toString());
    _instance.options.connectTimeout = _connectionTimeout;
    _instance.options.receiveTimeout = _receiveTimeout;
  }

  Dio get instance {
    return _instance;
  }

  DIOResponseBody errorHelper(dynamic error) {
    logger.e(error);
    return DIOResponseBody(
        success: false, data: error.response.data["message"]);
  }
}
