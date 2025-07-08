import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _firebaseAuth;

  RegisterBloc(this._firebaseAuth) : super(RegisterState.initial()) {
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, errorMessage: null));
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, errorMessage: null));
    });

    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null));
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(isSubmitting: false, errorMessage: e.message));
      }
    });
  }
}
