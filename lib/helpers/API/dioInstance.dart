import 'package:dio/dio.dart';

import '../../configurations/configurations.dart';

class DioInstance {
  final Dio _instance = new Dio();
  DioInstance() {
    _instance.options.baseUrl = Configurations().backendUrl + '/api/';
    _instance.options.connectTimeout=5000;
    _instance.options.receiveTimeout=3000;
  }

  Dio get construct {
    return _instance;
  }
}
