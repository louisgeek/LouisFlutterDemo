import 'package:dio/dio.dart';

import 'api_result.dart';
import '../error/error_mapper.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio _dio;

  // 单例访问点
  static ApiClient get instance => _instance;

  factory ApiClient() => _instance;

  // 私有构造函数
  ApiClient._internal() {
    _initDio();
  }

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    // 添加拦截器
    // _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 添加 token
          final token = _getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (e, handler) {
          if (e.response?.statusCode == 401) {
            print('token 过期，跳转登录');
          }
          handler.next(e);
        },
      ),
    ]);
  }

  String? _getToken() => null; // 从本地存储读取

  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    final res = await _dio.get(path, queryParameters: params);
    return res.data;
  }

  // Future<dynamic> post(String path, {dynamic data}) async {
  //   final res = await _dio.post(path, data: data);
  //   return res.data;
  // }

  // Future<T> post<T>(String path, {Object? data}) async {
  //   final res = await _dio.post<T>(path, data: data);
  //   return res.data as T;
  // }

  Future<ApiResult<T>> post<T>(String path, {Object? data}) async {
    try {
      final res = await _dio.post<T>(path, data: data);
      return ApiSuccess(res.data as T);
    } on DioException catch (e) {
      final error = ErrorMapper.mapDioError(e);
      return ApiFailure(error.message, code: error.code);
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  //在封装层统一处理异常，返回解包后的数据
  // Future<dynamic> post(String path, {dynamic data}) async {
  //   try {
  //     final res = await _dio.post(path, data: data);
  //     return ApiSuccess(res.data); //转换为业务层统一的结果类型
  //   } on DioException catch (e) {
  //     final error = ErrorMapper.mapDioError(e);
  //     return ApiFailure(error.message, code: error.code);
  //   } catch (e) {
  //     return ApiFailure('post 失败: $e');
  //   }
  // }

}

void main() async{
  // ApiClient.instance.get('/posts/1').then((value) {
  //   print(value);
  // });
  await ApiClient().get('/posts/1').then((value) {
    print(value);
  });
  // ApiClient.instance.post('/posts', data: {
  //   'title': 'foo',
  //   'body': 'bar',
  //   'userId': 1,
  // }).then((value) {
  //   print(value);
  // });
}
