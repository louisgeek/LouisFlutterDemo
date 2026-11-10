import 'package:flutter/foundation.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecase/login_usecase.dart';
import 'login_ui_state.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  
  var _state = LoginUiState.initial();
  LoginUiState get state => _state;
  
  LoginViewModel(this.loginUsecase);
  
  Future<void> login(String email, String password) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();
    
    final result = await loginUsecase.execute(email, password);
    
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