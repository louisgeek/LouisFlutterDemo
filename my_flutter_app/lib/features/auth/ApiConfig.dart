

import 'package:dio/dio.dart';

import '../../core/network/api_client.dart';
import 'AppEnvironment.dart';

class ApiConfig {
  static String get baseUrl => _currentAppEnv.baseUrl;
  static AppEnvironment _currentAppEnv = AppEnvironment.prod;

  static void updateUserConfigEnvironment(AppEnvironment env) {
    _currentAppEnv = env;
    // 重新初始化 Dio
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  static late Dio _dio;
  static ApiClient get client => ApiClient(_dio);
}

