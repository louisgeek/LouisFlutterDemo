import 'package:dio/dio.dart';
import 'model/login_request.dart';
import 'model/login_response.dart';

class AuthApi {
  final Dio dio;
  
  AuthApi(this.dio) {
    dio.interceptors.add(LogInterceptor());
  }
  
  static AuthApi create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );
    return AuthApi(dio);
  }
  
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await dio.post('/auth/login', data: request.toJson());
    return LoginResponse.fromJson(response.data);
  }
  
  Future<LoginResponse> register(RegisterRequest request) async {
    final response = await dio.post('/auth/register', data: request.toJson());
    return LoginResponse.fromJson(response.data);
  }
}

class RegisterRequest {
  final String username;
  final String email;
  final String password;
  
  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}