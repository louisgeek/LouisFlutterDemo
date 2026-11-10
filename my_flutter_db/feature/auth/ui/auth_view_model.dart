import 'package:flutter/foundation.dart';
import '../../domain/model/user.dart';
import '../../domain/usecase/login_usecase.dart';

class AuthViewModel extends ChangeNotifier {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final LogoutUsecase logoutUsecase;
  
  User? _user;
  User? get user => _user;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  AuthViewModel({
    required this.getCurrentUserUsecase,
    required this.logoutUsecase,
  });
  
  Future<void> loadCurrentUser() async {
    _isLoading = true;
    notifyListeners();
    
    _user = await getCurrentUserUsecase.execute();
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    
    await logoutUsecase.execute();
    _user = null;
    
    _isLoading = false;
    notifyListeners();
  }
  
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}