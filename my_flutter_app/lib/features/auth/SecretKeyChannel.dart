import 'package:flutter/services.dart';

class SecretKeyChannel {
  static const platform = MethodChannel('com.louis.my_flutter_app/sign_secret'); //和原生端完全一致

  static Future<String> getSignSecretKey() async {
    try {
      return await platform.invokeMethod('getSignSecretKey');
    } catch (e) {
      return '';
    }
  }
}