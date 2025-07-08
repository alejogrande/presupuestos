// bloc/add_entry_state.dart
import 'package:equatable/equatable.dart';

class AddEntryState extends Equatable {
  final String title;
  final String amount;
  final String category;
  final DateTime date;
  final String descripcion;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const AddEntryState({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.descripcion,
    required this.isSubmitting,
    required this.isSuccess,
    this.errorMessage,
  });

  factory AddEntryState.initial() => AddEntryState(
    title: '',
    amount: '',
    category: '',
    date: DateTime.now(),
    descripcion: '',
    isSubmitting: false,
    isSuccess: false,
    errorMessage: null,
  );

  AddEntryState copyWith({
    String? title,
    String? amount,
    String? category,
    DateTime? date,
    String? descripcion,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return AddEntryState(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      descripcion: descripcion ?? this.descripcion,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    title,
    amount,
    category,
    date,
    descripcion,
    isSubmitting,
    isSuccess,
    errorMessage,
  ];
}

extension AddEntryStateX on AddEntryState {
  bool get isValid {
    final parsedAmount = double.tryParse(amount);
    return title.trim().isNotEmpty &&
        (parsedAmount != null && parsedAmount > 0) &&
        category.trim().isNotEmpty;
  }
}
