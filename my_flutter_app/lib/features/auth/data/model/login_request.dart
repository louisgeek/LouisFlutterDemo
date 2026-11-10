

import 'package:flutter/foundation.dart';

@immutable
class LoginRequest {
  final String userName;
  final String password; //密码。SHA256 对密码加密然后转小写
  final String? phoneCode; //手机区号，默认86

  const LoginRequest({
    required this.userName,
    required this.password,
    this.phoneCode = '86',
  });

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'password': password,
    'phoneCode': phoneCode,
  };
}