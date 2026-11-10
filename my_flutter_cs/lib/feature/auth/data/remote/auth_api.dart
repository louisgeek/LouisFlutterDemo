import 'package:dio/dio.dart';
import 'model/login_request.dart';
import 'model/login_response.dart';
import 'model/register_request.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await dio.post('/auth/login', data: request.toJson());
    return LoginResponse.fromJson(response.data);
  }

  Future<LoginResponse> register(RegisterRequest request) async {
    final response = await dio.post('/auth/register', data: request.toJson());
    return LoginResponse.fromJson(response.data);
  }
}
