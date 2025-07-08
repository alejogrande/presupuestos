part of 'register_bloc.dart';

class RegisterState {
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  RegisterState({
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.isSuccess,
    required this.errorMessage,
  });

  factory RegisterState.initial() => RegisterState(
        email: '',
        password: '',
        isSubmitting: false,
        isSuccess: false,
        errorMessage: null,
      );

  RegisterState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
