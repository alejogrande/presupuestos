// 📁 data/repositories/transaction_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:presupuestos/data/datasource/firebase_transaction_datasource.dart';
import 'package:presupuestos/data/failure.dart';
import 'package:presupuestos/core/helpers/firebase_helper.dart';
import 'package:presupuestos/domain/repositories/transaction_repository.dart';
import 'package:presupuestos/data/model/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final FirebaseTransactionDataSource transactionDataSource;

  TransactionRepositoryImpl(this.transactionDataSource);

  @override
  Future<Either<Failure, void>> addTransaction(
    String userId,
    TransactionModel transaction,
  ) {
    return handleEither(
      () => transactionDataSource.addTransaction(userId, transaction),
    );
  }

  @override
  Stream<List<TransactionModel>> getTransactions(String userId) {
    return transactionDataSource.getTransactions(userId);
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getFilteredTransactions({
    required String userId,
    required String type,
    DateTimeRange? dateRange,
    String? categoryId,
    String? title,
  }) {
    return handleEither(
      () => transactionDataSource.getFilteredTransactions(
        userId: userId,
        type: type,
        dateRange: dateRange,
        categoryId: categoryId,
        title:title,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> deleteTransaction({
    required String userId,
    required String transactionId,
  }) {
    return handleEither(
      () => transactionDataSource.deleteTransaction(
        userId: userId,
        transactionId: transactionId,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> updateTransaction({
    required String userId,
    required TransactionModel transaction,
  }) {
    return handleEither(
      () => transactionDataSource.updateTransaction(
        userId: userId,
        transaction: transaction,
      ),
    );
  }
}
