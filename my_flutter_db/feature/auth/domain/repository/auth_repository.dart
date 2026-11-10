import 'package:my_flutter_db/core/network/api_result.dart';
import 'package:my_flutter_db/feature/auth/domain/model/user.dart';

abstract class AuthRepository {
  Future<ApiResult<User>> login(String email, String password);
  Future<ApiResult<User>> register(String username, String email, String password);
  Future<User?> getCurrentUser();
  Future<void> logout();
}