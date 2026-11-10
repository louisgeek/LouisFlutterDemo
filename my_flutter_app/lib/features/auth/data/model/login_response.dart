import 'package:flutter/foundation.dart';

@immutable
class LoginResponse {
  final int refreshTokenExpireTime; //refreshToken失效时间（毫秒）
  final int accessTokenExpireTime; //accessToken失效时间（毫秒）
  final String accessToken; //登录成功token，用于后续请求，默认有效期一小时（目前为3小时）
  final String userId; //用户id
  final String refreshToken; //刷新token，用于accessToken过期后重新获取，默认有效期六个月

  const LoginResponse({
    required this.refreshTokenExpireTime,
    required this.accessTokenExpireTime,
    required this.accessToken,
    required this.userId,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      refreshTokenExpireTime: json['refreshTokenExpireTime'],
      accessTokenExpireTime: json['accessTokenExpireTime'],
      accessToken: json['accessToken'],
      userId: json['userId'],
      refreshToken: json['refreshToken'],
    );
  }
}
