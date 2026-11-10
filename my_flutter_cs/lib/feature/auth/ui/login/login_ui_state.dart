class LoginUiState {
  final bool isLoading;
  final String? errorMessage;

  LoginUiState({this.isLoading = false, this.errorMessage});

  LoginUiState copyWith({bool? isLoading, String? errorMessage}) {
    return LoginUiState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
