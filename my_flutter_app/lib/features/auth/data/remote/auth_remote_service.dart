import '../../../../core/network/api_client.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';

class AuthRemoteService {
  final ApiClient _client;
  AuthRemoteService(this._client);

  Future<LoginResponse> login(LoginRequest req) async {
    return  await _client.login();
  }
}