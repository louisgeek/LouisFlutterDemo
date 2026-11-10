import 'package:my_flutter_db/feature/auth/domain/model/user.dart';

class RegisterState {
  final bool isLoading;
  final String? error;
  final User? user;
  
  RegisterState({
    required this.isLoading,
    this.error,
    this.user,
  });
  
  factory RegisterState.initial() {
    return RegisterState(
      isLoading: false,
      error: null,
      user: null,
    );
  }
  
  RegisterState copyWith({
    bool? isLoading,
    String? error,
    User? user,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}