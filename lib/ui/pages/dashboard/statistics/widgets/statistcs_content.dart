import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:presupuestos/data/model/transaction_model.dart';

class StatisticsContent extends StatelessWidget {
  final List<TransactionModel> transactions;
  final void Function(TransactionModel) onDelete;
  final void Function(TransactionModel) onEdit;

  const StatisticsContent({
    super.key,
    required this.transactions,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final dataByCategory = <String, double>{};
    for (var t in transactions) {
      dataByCategory[t.category] = (dataByCategory[t.category] ?? 0) + t.amount;
    }

    final sections = dataByCategory.entries.map((e) {
      return PieChartSectionData(
        value: e.value,
        title: e.key,
        radius: 60,
        titleStyle: const TextStyle(fontSize: 12),
      );
    }).toList();

    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      child: CustomScrollView(
        slivers: [
          // Gráfico de pastel
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      height: 220,
                      child: PieChart(
                        PieChartData(
                          sections: sections,
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(thickness: 1),
              ],
            ),
          ),

          // Lista de transacciones
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        transaction.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${transaction.category} • ${_formatDate(transaction.date)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Text(
                        '\$${transaction.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: transaction.type == 'expense'
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              transaction.description.isNotEmpty
                                  ? transaction.description
                                  : 'Sin descripción',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => onEdit(transaction),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => onDelete(transaction),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: transactions.length,
            ),
          ),

          // Holgura para evitar que se tape con el FAB
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
