import 'package:flutter/foundation.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecase/login_usecase.dart';
import 'register_state.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterUsecase registerUsecase;
  
  var _state = RegisterState.initial();
  RegisterState get state => _state;
  
  RegisterViewModel(this.registerUsecase);
  
  Future<void> register(String username, String email, String password) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();
    
    final result = await registerUsecase.execute(username, email, password);
    
    if (result is ApiSuccess) {
      _state = _state.copyWith(
        isLoading: false,
        user: result.data,
      );
    } else {
      _state = _state.copyWith(
        isLoading: false,
        error: (result as ApiError).error.toString(),
      );
    }
    
    notifyListeners();
  }
}