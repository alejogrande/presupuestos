import 'package:presupuestos/data/enums/entry_type.dart';

class TransactionEntity {
  final String id;
  final double amount;
  final DateTime date;
  final EntryType type;
  final String categoryId;
  final String categoryName;
  final String comment;

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.categoryId,
    required this.categoryName,
    required this.comment,
  });
}
