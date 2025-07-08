import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presupuestos/data/enums/entry_type.dart';
import 'package:presupuestos/data/model/transaction_model.dart';
import 'package:presupuestos/domain/use_cases/auth_use_cases.dart';
import 'package:presupuestos/domain/use_cases/transaction_use_cases.dart';
import 'add_entry_event.dart';
import 'add_entry_state.dart';

class AddEntryBloc extends Bloc<AddEntryEvent, AddEntryState> {
  final EntryType entryType;
  final AuthUseCases authUseCases;
  final TransactionUseCases transactionUseCases;

  AddEntryBloc({
    required this.entryType,
    required this.authUseCases,
    required this.transactionUseCases,
  }) : super(AddEntryState.initial()) {
    on<TitleChanged>((event, emit) {
      emit(
        state.copyWith(
          title: event.title,
          errorMessage: null,
          isSuccess: false,
        ),
      );
    });

    on<AmountChanged>((event, emit) {
      emit(
        state.copyWith(
          amount: event.amount,
          errorMessage: null,
          isSuccess: false,
        ),
      );
    });

    on<CategoryChanged>((event, emit) {
      emit(
        state.copyWith(
          category: event.category,
          errorMessage: null,
          isSuccess: false,
        ),
      );
    });

    on<DateChanged>((event, emit) {
      emit(
        state.copyWith(date: event.date, errorMessage: null, isSuccess: false),
      );
    });

    on<CommentChanged>((event, emit) {
      emit(
        state.copyWith(
          descripcion: event.descripcion,
          errorMessage: null,
          isSuccess: false,
        ),
      );
    });

    on<SubmitEntry>((event, emit) async {
      emit(
        state.copyWith(
          isSubmitting: true,
          errorMessage: null,
          isSuccess: false,
        ),
      );

      final user = authUseCases.getCurrentUser();

      if (user == null) {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: 'Usuario no autenticado',
          ),
        );
        return;
      }

      final amount = double.tryParse(state.amount);
      if (amount == null || amount <= 0) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: 'Monto inválido'),
        );
        return;
      }

      if (state.title.trim().isEmpty) {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: 'Título es obligatorio',
          ),
        );
        return;
      }

      if (state.category.trim().isEmpty) {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: 'Categoría es obligatoria',
          ),
        );
        return;
      }

      final transaction = TransactionModel(
        id: '', // Firestore lo autogenerará
        title: state.title,
        amount: amount,
        date: state.date,
        type: entryType.name,
        category: state.category,
        description: state.descripcion.isEmpty
            ? 'Sin descripcion'
            : state.descripcion,
      );

      final result = await transactionUseCases.addTransaction(
        user.uid,
        transaction,
      );

      result.fold(
        (failure) => emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        ),
        (_) {
          // Opcional: resetear algunos campos después de éxito
          emit(
            state.copyWith(
              isSubmitting: false,
              isSuccess: true,
              amount: '',
              title: '',
              descripcion: '',
              category: '',
              // date: DateTime.now(),  // Opcional reset fecha
            ),
          );
        },
      );
    });
  }
}
