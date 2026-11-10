import 'package:flutter/foundation.dart';
import '../domain/model/user.dart';
import '../domain/repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository repository;
  User? _user;

  AuthViewModel(this.repository) {
    _user = repository.getCurrentUser();
  }

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> logout() async {
    await repository.logout();
    _user = null;
    notifyListeners();
  }
}
