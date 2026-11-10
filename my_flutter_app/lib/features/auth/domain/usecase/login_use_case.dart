
import '../../data/repository/auth_repository.dart';

/// 登录用例 - 包含业务逻辑
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  /// 执行登录用例
  Future<UserEntity> execute(LoginParams params) async {
    // 业务验证
    _validateParams(params);

    // 执行登录
    return _authRepository.login(
      username: params.username.trim(),
      password: params.password,
      rememberMe: params.rememberMe,
    );
  }

  /// 参数验证
  void _validateParams(LoginParams params) {
    if (params.username.trim().isEmpty) {
      throw const AuthFailure(message: '用户名不能为空');
    }

    if (params.password.isEmpty) {
      throw const AuthFailure(message: '密码不能为空');
    }

    if (params.password.length < 6) {
      throw const AuthFailure(message: '密码长度不能少于6位');
    }

    if (params.username.trim().length < 3) {
      throw const AuthFailure(message: '用户名长度不能少于3位');
    }
  }
}