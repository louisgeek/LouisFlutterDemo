import '../../../core/network/api_result.dart';
import '../local/local_data_source.dart';
import '../local/entity/user_entity.dart';
import '../remote/auth_api.dart';
import '../remote/model/login_request.dart';
import '../remote/remote_data_source.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<ApiResult<User>> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final result = await remoteDataSource.login(request);
    
    if (result is ApiSuccess) {
      final user = result.data;
      final userCompanion = UsersCompanion(
        id: Value(user.user.id),
        name: Value(user.user.name),
        email: Value(user.user.email),
        token: Value(user.token),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      );
      
      await localDataSource.saveUser(userCompanion);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', user.token);
      
      return ApiSuccess(
        User(
          id: user.user.id,
          name: user.user.name,
          email: user.user.email,
          token: user.token,
        ),
      );
    } else {
      return result as ApiError<User>;
    }
  }
  
  @override
  Future<ApiResult<User>> register(String username, String email, String password) async {
    final request = RegisterRequest(
      username: username,
      email: email,
      password: password,
    );
    
    final result = await remoteDataSource.register(request);
    
    if (result is ApiSuccess) {
      final user = result.data;
      final userCompanion = UsersCompanion(
        id: Value(user.user.id),
        name: Value(user.user.name),
        email: Value(user.user.email),
        token: Value(user.token),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      );
      
      await localDataSource.saveUser(userCompanion);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', user.token);
      
      return ApiSuccess(
        User(
          id: user.user.id,
          name: user.user.name,
          email: user.user.email,
          token: user.token,
        ),
      );
    } else {
      return result as ApiError<User>;
    }
  }
  
  @override
  Future<User?> getCurrentUser() async {
    final userEntity = await localDataSource.getCurrentUser();
    if (userEntity == null) return null;
    
    return User(
      id: userEntity.id,
      name: userEntity.name ?? '',
      email: userEntity.email,
      token: userEntity.token ?? '',
    );
  }
  
  @override
  Future<void> logout() async {
    final user = await localDataSource.getCurrentUser();
    if (user != null) {
      await localDataSource.deleteUser(user.id);
    }
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}