import 'package:flutter/foundation.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repository/auth_repository.dart';
import 'register_state.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthRepository repository;
  RegisterState _state = RegisterState();

  RegisterViewModel(this.repository);

  RegisterState get state => _state;

  Future<bool> register(String email, String password, String name) async {
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    final result = await repository.register(email, password, name);

    switch (result) {
      case Success(:final data):
        _state = RegisterState(isLoading: false);
        notifyListeners();
        return true;
      case Failure(:final message):
        _state = _state.copyWith(isLoading: false, errorMessage: message);
        notifyListeners();
        return false;
    }
  }
}
