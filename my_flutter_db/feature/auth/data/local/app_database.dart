import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'entity/user_entity.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  @override
  int get schemaVersion => 1;
  
  Future<User?> getCurrentUser() => (select(users)..limit(1)).getSingleOrNull();
  
  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);
  
  Future<int> updateUser(UsersCompanion user) => update(users).replace(user);
  
  Future<int> deleteUser(int id) => (delete(users)..where((u) => u.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}