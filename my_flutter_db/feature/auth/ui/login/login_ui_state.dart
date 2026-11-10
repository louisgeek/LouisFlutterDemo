import 'package:my_flutter_db/feature/auth/domain/model/user.dart';

class LoginUiState {
  final bool isLoading;
  final String? error;
  final User? user;
  
  LoginUiState({
    required this.isLoading,
    this.error,
    this.user,
  });
  
  factory LoginUiState.initial() {
    return LoginUiState(
      isLoading: false,
      error: null,
      user: null,
    );
  }
  
  LoginUiState copyWith({
    bool? isLoading,
    String? error,
    User? user,
  }) {
    return LoginUiState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}