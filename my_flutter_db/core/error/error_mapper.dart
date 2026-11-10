import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_flutter_db/core/error/api_error.dart';

class ErrorMapper {
  static ApiError mapError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        return ApiError.fromJson(error.response!.data);
      } else if (error.error is SocketException) {
        return ApiError(
          statusCode: 408,
          message: 'Network error. Please check your internet connection.',
        );
      } else {
        return ApiError(
          statusCode: 500,
          message: 'Unknown error occurred.',
        );
      }
    } else {
      return ApiError(
        statusCode: 500,
        message: error.toString(),
      );
    }
  }
}