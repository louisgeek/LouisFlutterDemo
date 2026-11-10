import 'package:dio/dio.dart';
import 'api_error.dart';

class ErrorMapper {
  static ApiError mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError('连接超时，请检查网络');
      case DioExceptionType.badResponse:
        return ApiError(
          error.response?.data['message'] ?? '服务器错误',
          code: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiError('请求已取消');
      default:
        return ApiError('网络错误，请稍后重试');
    }
  }
}
