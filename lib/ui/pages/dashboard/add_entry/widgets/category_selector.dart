import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/add_entry_bloc.dart';
import '../bloc/add_entry_event.dart';

class CategorySelector extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final String selectedCategory;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: categories.map((cat) {
        final isSelected = selectedCategory == cat['name'];
        return GestureDetector(
          onTap: () => context.read<AddEntryBloc>().add(CategoryChanged(cat['name'])),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: isSelected ? theme.colorScheme.primary : Colors.grey.shade300,
                child: Icon(
                  cat['icon'],
                  size: 28,
                  color: isSelected ? Colors.white : Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                cat['name'],
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
