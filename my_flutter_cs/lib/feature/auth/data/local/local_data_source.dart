import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  static const _keyToken = 'auth_token';
  static const _keyUserId = 'user_id';
  static const _keyUserEmail = 'user_email';
  static const _keyUserName = 'user_name';

  final SharedPreferences prefs;

  LocalDataSource(this.prefs);

  Future<void> saveToken(String token) async {
    await prefs.setString(_keyToken, token);
  }

  String? getToken() => prefs.getString(_keyToken);

  Future<void> saveUser(String id, String email, String name) async {
    await prefs.setString(_keyUserId, id);
    await prefs.setString(_keyUserEmail, email);
    await prefs.setString(_keyUserName, name);
  }

  Map<String, String>? getUser() {
    final id = prefs.getString(_keyUserId);
    final email = prefs.getString(_keyUserEmail);
    final name = prefs.getString(_keyUserName);
    if (id == null || email == null || name == null) return null;
    return {'id': id, 'email': email, 'name': name};
  }

  Future<void> clear() async {
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserName);
  }
}
