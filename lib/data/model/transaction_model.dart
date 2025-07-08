import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String type;
  final String category;
  final String description;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'amount': amount,
    'date': date, // ✅ Cambio aquí
    'type': type,
    'category': category,
    'description': description,
  };

  factory TransactionModel.fromMap(String id, Map<String, dynamic> map) {
    return TransactionModel(
      id: id,
      title: map['title'],
      amount: (map['amount'] as num).toDouble(),
      date: (map['date'] as Timestamp)
          .toDate(), // ✅ Firestore lo guarda como Timestamp
      type: map['type'],
      category: map['category'],
      description: map['description'],
    );
  }
}
