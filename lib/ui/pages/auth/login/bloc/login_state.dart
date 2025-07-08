part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  LoginState({
    required this.email,
    required this.password,
    required this.isSubmitting,
    this.errorMessage,
    required this.isSuccess,
  });

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      isSubmitting: false,
      errorMessage: null,
      isSuccess: false,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
