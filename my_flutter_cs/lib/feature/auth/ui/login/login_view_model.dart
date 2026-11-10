import 'package:flutter/foundation.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repository/auth_repository.dart';
import 'login_ui_state.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository repository;
  LoginUiState _state = LoginUiState();

  LoginViewModel(this.repository);

  LoginUiState get state => _state;

  Future<bool> login(String email, String password) async {
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    final result = await repository.login(email, password);

    switch (result) {
      case Success(:final data):
        _state = LoginUiState(isLoading: false);
        notifyListeners();
        return true;
      case Failure(:final message):
        _state = _state.copyWith(isLoading: false, errorMessage: message);
        notifyListeners();
        return false;
    }
  }
}
