import '../../../../core/network/api_result.dart';
import '../model/user.dart';

abstract class AuthRepository {
  Future<ApiResult<User>> login(String email, String password);
  Future<ApiResult<User>> register(String email, String password, String name);
  Future<void> logout();
  User? getCurrentUser();
  bool isLoggedIn();
}
