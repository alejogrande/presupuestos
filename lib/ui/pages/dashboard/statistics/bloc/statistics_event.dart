part of 'statistics_bloc.dart';

sealed class StatisticsEvent {}

class LoadStatistics extends StatisticsEvent {
  final EntryType entryType;
  final DateTimeRange? dateRange;
  final String? categoryId;
  final String? title;

  LoadStatistics({
    required this.entryType,
    this.dateRange,
    this.categoryId,
    titleQuery,
    this.title,
  });
}

class DeleteTransaction extends StatisticsEvent {
  final TransactionModel transaction;

  DeleteTransaction({required this.transaction});
}

class EditTransaction extends StatisticsEvent {
  final TransactionModel transaction;

  EditTransaction({required this.transaction});
}
