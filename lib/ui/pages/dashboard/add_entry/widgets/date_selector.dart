import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/add_entry_bloc.dart';
import '../bloc/add_entry_event.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;

  const DateSelector({super.key, required this.selectedDate});

  @override
  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime date) => DateFormat('dd MMM').format(date);

    bool isSameDate(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final twoDaysAgo = now.subtract(const Duration(days: 2));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _QuickDateButton(
          label: 'Hoy\n${_formatDate(now)}',
          onTap: () => context.read<AddEntryBloc>().add(DateChanged(now)),
          isSelected: isSameDate(selectedDate, now),
        ),
        _QuickDateButton(
          label: 'Ayer\n${_formatDate(yesterday)}',
          onTap: () => context.read<AddEntryBloc>().add(DateChanged(yesterday)),
          isSelected: isSameDate(selectedDate, yesterday),
        ),
        _QuickDateButton(
          label: 'Hace 2 días\n${_formatDate(twoDaysAgo)}',
          onTap: () =>
              context.read<AddEntryBloc>().add(DateChanged(twoDaysAgo)),
          isSelected: isSameDate(selectedDate, twoDaysAgo),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              context.read<AddEntryBloc>().add(DateChanged(picked));
            }
          },
        ),
      ],
    );
  }
}

class _QuickDateButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuickDateButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary.withOpacity(0.2)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? theme.colorScheme.primary : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
