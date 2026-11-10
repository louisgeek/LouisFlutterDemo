import 'package:shared_preferences/shared_preferences.dart';

class GlobalConfigManager {
  static const String _keyUserConfigEnvironment = 'KEY_USER_CONFIG_ENVIRONMENT';
  static const String _buildConfigEnvironment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'pro',
  );

  static Future<String?> getUserConfigEnvironment() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_keyUserConfigEnvironment);
  }

  static Future<void> setUserConfigEnvironment(String environment) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_keyUserConfigEnvironment, environment);
  }

  static Future<String> getEnvironment() async {
    final userConfigEnvironment = await getUserConfigEnvironment();
    // 如果用户配置了环境，返回用户配置
    if (userConfigEnvironment != null && userConfigEnvironment.isNotEmpty) {
      return userConfigEnvironment;
    }
    // 否则返回打包环境
    return _buildConfigEnvironment;
  }
}
