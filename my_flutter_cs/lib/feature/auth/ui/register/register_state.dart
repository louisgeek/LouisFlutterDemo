class RegisterState {
  final bool isLoading;
  final String? errorMessage;

  RegisterState({this.isLoading = false, this.errorMessage});

  RegisterState copyWith({bool? isLoading, String? errorMessage}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
