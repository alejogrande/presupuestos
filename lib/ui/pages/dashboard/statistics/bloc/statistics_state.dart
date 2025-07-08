part of 'statistics_bloc.dart';

class StatisticsState extends Equatable {
  final List<TransactionModel> transactions;
  final bool isLoading;
  final String? error;
  final TransactionModel? editingTransaction;

  const StatisticsState({
    this.transactions = const [],
    this.isLoading = false,
    this.error,
    this.editingTransaction,
  });

  StatisticsState copyWith({
    List<TransactionModel>? transactions,
    bool? isLoading,
    String? error,
    TransactionModel? editingTransaction,
  }) {
    return StatisticsState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      editingTransaction: editingTransaction,
    );
  }

  @override
  List<Object?> get props => [
    transactions,
    isLoading,
    error,
    editingTransaction,
  ];

  double get totalAmount => transactions.fold(0.0, (sum, t) => sum + t.amount);
}
