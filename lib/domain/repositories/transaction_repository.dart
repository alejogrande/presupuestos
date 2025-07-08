import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:presupuestos/data/failure.dart';
import 'package:presupuestos/data/model/transaction_model.dart';

abstract class TransactionRepository {
  Future<Either<Failure, void>> addTransaction(
    String userId,
    TransactionModel transaction,
  );
  Stream<List<TransactionModel>> getTransactions(String userId);

  Future<Either<Failure, List<TransactionModel>>> getFilteredTransactions({
    required String userId,
    required String type, // 'expense' o 'income'
    DateTimeRange? dateRange,
    String? categoryId,
    String? title,
  });

  /// Elimina la transacción con el [transactionId] para el usuario [userId].
  Future<Either<Failure, void>> deleteTransaction({
    required String userId,
    required String transactionId,
  });

  /// Actualiza la transacción indicada en [transaction].
  Future<Either<Failure, void>> updateTransaction({
    required String userId,
    required TransactionModel transaction,
  });
}
