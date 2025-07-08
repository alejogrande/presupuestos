import 'package:flutter/material.dart';
import 'package:presupuestos/data/enums/entry_type.dart';

List<Map<String, dynamic>> getDefaultCategoriesByType(EntryType type) {
  return type == EntryType.expense
      ? [
          {'name': 'Comida', 'icon': Icons.fastfood},
          {'name': 'Transporte', 'icon': Icons.directions_car},
          {'name': 'Salud', 'icon': Icons.health_and_safety},
          {'name': 'Entretenimiento', 'icon': Icons.movie},
          {'name': 'Otro', 'icon': Icons.more_horiz},
        ]
      : [
          {'name': 'Salario', 'icon': Icons.work},
          {'name': 'Freelance', 'icon': Icons.laptop},
          {'name': 'Regalo', 'icon': Icons.card_giftcard},
          {'name': 'Inversión', 'icon': Icons.trending_up},
          {'name': 'Otro', 'icon': Icons.more_horiz},
        ];
}
