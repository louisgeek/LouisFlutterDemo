import 'package:drift/drift.dart';
import '../app_database.dart';
import '../entity/user_entity.dart';

class UserDao {
  final AppDatabase db;
  
  UserDao(this.db);
  
  Future<User?> getCurrentUser() => db.getCurrentUser();
  
  Future<int> insertUser(UsersCompanion user) => db.insertUser(user);
  
  Future<int> updateUser(UsersCompanion user) => db.updateUser(user);
  
  Future<int> deleteUser(int id) => db.deleteUser(id);
}