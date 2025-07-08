import 'package:presupuestos/data/enums/entry_type.dart';

EntryType mapStringToEntryType(String? value) {
  switch (value) {
    case 'income':
      return EntryType.income;
    case 'expense':
      return EntryType.expense;
    default:
      return EntryType.income; // Valor por defecto
  }
}