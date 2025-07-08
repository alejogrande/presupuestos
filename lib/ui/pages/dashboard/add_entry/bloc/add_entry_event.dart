// bloc/add_entry_event.dart
import 'package:equatable/equatable.dart';

abstract class AddEntryEvent extends Equatable {
  const AddEntryEvent();
  @override
  List<Object?> get props => [];
}

class AmountChanged extends AddEntryEvent {
  final String amount;
  const AmountChanged(this.amount);
  @override
  List<Object?> get props => [amount];
}

class TitleChanged extends AddEntryEvent {
  final String title;
  const TitleChanged(this.title);
  @override
  List<Object?> get props => [title];
}

class CategoryChanged extends AddEntryEvent {
  final String category;
  const CategoryChanged(this.category);
  @override
  List<Object?> get props => [category];
}

class DateChanged extends AddEntryEvent {
  final DateTime date;
  const DateChanged(this.date);
  @override
  List<Object?> get props => [date];
}

class CommentChanged extends AddEntryEvent {
  final String descripcion;
  const CommentChanged(this.descripcion);
  @override
  List<Object?> get props => [descripcion];
}

class SubmitEntry extends AddEntryEvent {
  const SubmitEntry();
}
