import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/transaction_model.dart';

abstract class FirebaseTransactionDataSource {
  Future<void> addTransaction(String userId, TransactionModel transaction);
  Stream<List<TransactionModel>> getTransactions(String userId);
  Future<List<TransactionModel>> getFilteredTransactions({
    required String userId,
    required String type,
    DateTimeRange? dateRange,
    String? categoryId,
    String? title,
  });

  /// Elimina la transacción con [transactionId] para el usuario [userId].
  Future<void> deleteTransaction({
    required String userId,
    required String transactionId,
  });

  /// Actualiza la transacción existente. Usa [transaction.id] para referenciar el documento.
  Future<void> updateTransaction({
    required String userId,
    required TransactionModel transaction,
  });
}

class FirebaseTransactionDataSourceImpl
    implements FirebaseTransactionDataSource {
  final FirebaseFirestore firestore;

  FirebaseTransactionDataSourceImpl(this.firestore);

  @override
  Future<void> addTransaction(
    String userId,
    TransactionModel transaction,
  ) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .add(transaction.toMap());
  }

  @override
  Stream<List<TransactionModel>> getTransactions(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TransactionModel.fromMap(doc.id, doc.data());
          }).toList();
        });
  }

  @override
  Future<List<TransactionModel>> getFilteredTransactions({
    required String userId,
    required String type,
    DateTimeRange? dateRange,
    String? categoryId,
    String? title,
  }) async {
    Query query = firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .where('type', isEqualTo: type);

    if (dateRange != null) {
      query = query
          .where('date', isGreaterThanOrEqualTo: dateRange.start)
          .where('date', isLessThanOrEqualTo: dateRange.end);
    }

    if (categoryId != null && categoryId.isNotEmpty) {
      query = query.where('category', isEqualTo: categoryId);
    }
    if (title != null && title.isNotEmpty) {
      query = query.where('title', isEqualTo: title);
    }

    query = query.orderBy('date', descending: true);

    final snapshot = await query.get();

    final transactions = snapshot.docs.map((doc) {
      return TransactionModel.fromMap(
        doc.id,
        doc.data() as Map<String, dynamic>,
      );
    }).toList();

    return transactions;
  }

  @override
  Future<void> deleteTransaction({
    required String userId,
    required String transactionId,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(transactionId)
        .delete();
  }

  @override
  Future<void> updateTransaction({
    required String userId,
    required TransactionModel transaction,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(transaction.id)
        .update(transaction.toMap());
  }
}
