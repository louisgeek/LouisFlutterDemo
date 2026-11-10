import 'package:dio/dio.dart';
import 'package:my_flutter_app/core/network/api_response.dart';
import 'package:retrofit/http.dart';

import '../../features/auth/data/model/login_request.dart';
import '../../features/auth/data/model/login_response.dart';

@RestApi(baseUrl: "https://api.example.com")
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST("/api/auth/v1/login")
  // Future<ApiResponse<LoginResponse>> login(@Header("X-PW-Timestamp") int timestamp, @Header("X-PW-Signature") String signature, @Body() Map<String, dynamic> params);


  @POST("/api/auth/v1/login")
  Future<ApiResponse<LoginResponse>> login(@Header("X-PW-Timestamp") int timestamp, @Header("X-PW-Signature") String signature, @Body() LoginRequest request);

}