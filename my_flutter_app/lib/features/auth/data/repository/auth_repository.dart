import '../../../../core/network/api_client.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<LoginResponse> login(String userName, String password,
      {String? phoneCode}) async {
    // 处理密码加密
    final encryptedPassword = _encryptPassword(password);

    // 生成签名和时间戳
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final signature = _generateSignature(timestamp);

    // 构建请求
    final request = LoginRequest(
      userName: userName,
      password: encryptedPassword,
      phoneCode: phoneCode,
    );

    // 发起请求
    final response = await _apiClient.login(timestamp, signature, request);

    // 处理响应
    if (response.isSuccess && response.data != null) {
      return response.data!;
    } else {
      throw Exception(response.msg ?? '登录失败');
    }
  }

  String _encryptPassword(String password) {
    // SHA256 加密并转小写
    // return sha256.convert(utf8.encode(password)).toString().toLowerCase();
    return password.toLowerCase();
  }

  String _generateSignature(int timestamp) {
    // 生成签名逻辑
    return 'your_signature';
  }
}
