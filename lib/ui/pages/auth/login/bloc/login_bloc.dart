import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presupuestos/domain/use_cases/auth_use_cases.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthUseCases authUseCases;

  LoginBloc(this.authUseCases) : super(LoginState.initial()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, errorMessage: null));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, errorMessage: null));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null, isSuccess: false));

      final result = await authUseCases.login(state.email, state.password);

      result.fold(
        (failure) {
          emit(state.copyWith(
            isSubmitting: false,
            errorMessage: failure.message,
          ));
        },
        (user) {
          emit(state.copyWith(
            isSubmitting: false,
            isSuccess: true,
          ));
        },
      );
    });
  }
}