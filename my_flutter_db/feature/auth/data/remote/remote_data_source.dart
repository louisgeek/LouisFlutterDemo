import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';
import 'auth_api.dart';
import 'model/login_request.dart';
import 'model/login_response.dart';

class RemoteDataSource {
  final AuthApi authApi;
  
  RemoteDataSource(this.authApi);
  
  Future<ApiResult<LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await authApi.login(request);
      return ApiSuccess(response);
    } catch (e) {
      return ApiError(e);
    }
  }
  
  Future<ApiResult<LoginResponse>> register(RegisterRequest request) async {
    try {
      final response = await authApi.register(request);
      return ApiSuccess(response);
    } catch (e) {
      return ApiError(e);
    }
  }
}