import 'dao/user_dao.dart';
import 'entity/user_entity.dart';

class LocalDataSource {
  final UserDao userDao;
  
  LocalDataSource(this.userDao);
  
  Future<User?> getCurrentUser() => userDao.getCurrentUser();
  
  Future<int> saveUser(UsersCompanion user) => userDao.insertUser(user);
  
  Future<int> updateUser(UsersCompanion user) => userDao.updateUser(user);
  
  Future<int> deleteUser(int id) => userDao.deleteUser(id);
}