enum LoginStatus { initial, loading, success, error  } 

class LoginUiState {
  final LoginStatus status;
  final String? errorMessage;

  LoginUiState({
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  LoginUiState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginUiState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}