import 'package:dio/dio.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../local/local_data_source.dart';
import '../remote/auth_api.dart';
import '../remote/model/login_request.dart';
import '../remote/model/register_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;
  final LocalDataSource local;

  AuthRepositoryImpl(this.api, this.local);

  @override
  Future<ApiResult<User>> login(String email, String password) async {
    try {
      final response = await api.login(LoginRequest(email: email, password: password));
      await local.saveToken(response.token);
      await local.saveUser(response.user.id, response.user.email, response.user.name);
      return Success(User(
        id: response.user.id,
        email: response.user.email,
        name: response.user.name,
      ));
    } on DioException catch (e) {
      final error = ErrorMapper.mapDioError(e);
      return Failure(error.message, code: error.code);
    } catch (e) {
      return Failure('登录失败: $e');
    }
  }

  @override
  Future<ApiResult<User>> register(String email, String password, String name) async {
    try {
      final response = await api.register(RegisterRequest(
        email: email,
        password: password,
        name: name,
      ));
      await local.saveToken(response.token);
      await local.saveUser(response.user.id, response.user.email, response.user.name);
      return Success(User(
        id: response.user.id,
        email: response.user.email,
        name: response.user.name,
      ));
    } on DioException catch (e) {
      final error = ErrorMapper.mapDioError(e);
      return Failure(error.message, code: error.code);
    } catch (e) {
      return Failure('注册失败: $e');
    }
  }

  @override
  Future<void> logout() async {
    await local.clear();
  }

  @override
  User? getCurrentUser() {
    final userData = local.getUser();
    if (userData == null) return null;
    return User(
      id: userData['id']!,
      email: userData['email']!,
      name: userData['name']!,
    );
  }

  @override
  bool isLoggedIn() => local.getToken() != null;
}
