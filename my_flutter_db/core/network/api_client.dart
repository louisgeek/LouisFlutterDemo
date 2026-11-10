import 'package:dio/dio.dart';
import '../../feature/auth/data/remote/model/login_request.dart';
import '../../feature/auth/data/remote/model/login_response.dart';

class ApiClient {
  final Dio dio;
  
  ApiClient(this.dio) {
    dio.interceptors.add(LogInterceptor());
  }
  
  static ApiClient create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );
    return ApiClient(dio);
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