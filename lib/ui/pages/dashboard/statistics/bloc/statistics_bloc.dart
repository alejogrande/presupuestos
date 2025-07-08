import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presupuestos/data/enums/entry_type.dart';
import 'package:presupuestos/data/model/transaction_model.dart';
import 'package:presupuestos/domain/use_cases/auth_use_cases.dart';
import 'package:presupuestos/domain/use_cases/transaction_use_cases.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final TransactionUseCases transactionUseCases;
  final AuthUseCases authUseCases;

  StatisticsBloc({
    required this.transactionUseCases,
    required this.authUseCases,
  }) : super(const StatisticsState()) {
    on<LoadStatistics>(_onLoadStatistics);
    on<DeleteTransaction>(_onDeleteTransaction);
    on<EditTransaction>(_onEditTransaction);
  }

  Future<void> _onLoadStatistics(
    LoadStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final user = authUseCases.getCurrentUser();
    if (user == null) {
      emit(state.copyWith(isLoading: false, error: 'Usuario no autenticado'));
      return;
    }

    final result = await transactionUseCases.getFilteredTransactions(
      userId: user.uid,
      type: event.entryType.name,
      dateRange: event.dateRange,
      categoryId: event.categoryId,
      title: event.title,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (transactions) => emit(
        state.copyWith(
          isLoading: false,
          error: null,
          transactions: transactions,
        ),
      ),
    );
  }

  Future<void> _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final user = authUseCases.getCurrentUser();
    if (user == null) {
      emit(state.copyWith(isLoading: false, error: 'Usuario no autenticado'));
      return;
    }
    final result = await transactionUseCases.deleteTransaction(
      userId: user.uid,
      transactionId: event.transaction.id,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        add(
          LoadStatistics(
            entryType: mapStringToEntryType(event.transaction.type),
          ),
        );
      },
    );
  }

  void _onEditTransaction(
    EditTransaction event,
    Emitter<StatisticsState> emit,
  ) {
    emit(state.copyWith(editingTransaction: event.transaction));
  }

  EntryType mapStringToEntryType(String value) {
    return EntryType.values.firstWhere((e) => e.name == value);
  }
}
