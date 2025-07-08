import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:presupuestos/data/failure.dart';
import 'package:presupuestos/data/model/transaction_model.dart';
import 'package:presupuestos/domain/repositories/transaction_repository.dart';

class TransactionUseCases {
  final TransactionRepository repository;

  TransactionUseCases(this.repository);

  Future<Either<Failure, void>> addTransaction(
    String userId,
    TransactionModel transaction,
  ) {
    return repository.addTransaction(userId, transaction);
  }

  Stream<List<TransactionModel>> getTransactions(String userId) {
    return repository.getTransactions(userId);
  }

  Future<Either<Failure, List<TransactionModel>>> getFilteredTransactions({
    required String userId,
    required String type, // 'expense' o 'income'
    DateTimeRange? dateRange,
    String? categoryId,
    String? title,
  }) {
    return repository.getFilteredTransactions(
      userId: userId,
      type: type,
      dateRange: dateRange,
      categoryId: categoryId,
      title: title
    );
  }

  /// Elimina una transacción existente.
  Future<Either<Failure, void>> deleteTransaction({
    required String userId,
    required String transactionId,
  }) {
    return repository.deleteTransaction(
      userId: userId,
      transactionId: transactionId,
    );
  }

  /// Actualiza una transacción existente.
  Future<Either<Failure, void>> updateTransaction({
    required String userId,
    required TransactionModel transaction,
  }) {
    return repository.updateTransaction(
      userId: userId,
      transaction: transaction,
    );
  }
}
