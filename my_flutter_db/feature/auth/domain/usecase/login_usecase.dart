import 'package:my_flutter_db/core/network/api_result.dart';
import 'package:my_flutter_db/feature/auth/domain/model/user.dart';
import 'package:my_flutter_db/feature/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;
  
  LoginUsecase(this.repository);
  
  Future<ApiResult<User>> execute(String email, String password) {
    return repository.login(email, password);
  }
}

class RegisterUsecase {
  final AuthRepository repository;
  
  RegisterUsecase(this.repository);
  
  Future<ApiResult<User>> execute(String username, String email, String password) {
    return repository.register(username, email, password);
  }
}

class GetCurrentUserUsecase {
  final AuthRepository repository;
  
  GetCurrentUserUsecase(this.repository);
  
  Future<User?> execute() {
    return repository.getCurrentUser();
  }
}

class LogoutUsecase {
  final AuthRepository repository;
  
  LogoutUsecase(this.repository);
  
  Future<void> execute() {
    return repository.logout();
  }
}