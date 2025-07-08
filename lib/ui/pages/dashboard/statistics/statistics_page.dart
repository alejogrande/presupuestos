import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:presupuestos/core/router/routes.dart';
import 'package:presupuestos/core/utils/category_utils.dart';
import 'package:presupuestos/data/enums/entry_type.dart';
import 'package:presupuestos/data/enums/period_enum.dart';
import 'package:presupuestos/ui/pages/dashboard/statistics/widgets/statistcs_content.dart';
import 'package:presupuestos/ui/widgets/generic_scafold.dart';
import 'bloc/statistics_bloc.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  PeriodFilter selectedPeriod = PeriodFilter.month;
  String? searchTitle;
  List<String> userCategories = []; // Llena esto desde el Bloc o en initState.
  DateTimeRange? selectedDateRange;
  String? selectedCategoryId;
  EntryType selectedType = EntryType.expense;

  @override
  void initState() {
    selectedDateRange = _calculateDateRange(selectedPeriod);
    super.initState();
    _loadStatistics();
  }

  void _loadStatistics() {
    context.read<StatisticsBloc>().add(
      LoadStatistics(
        entryType: selectedType,
        dateRange: selectedDateRange,
        categoryId: selectedCategoryId,
        titleQuery: searchTitle,
        title: searchTitle,
      ),
    );
  }

  DateTimeRange _calculateDateRange(PeriodFilter period) {
    final now = DateTime.now();
    switch (period) {
      case PeriodFilter.week:
        return DateTimeRange(
          start: now.subtract(const Duration(days: 7)),
          end: now,
        );
      case PeriodFilter.month:
        return DateTimeRange(
          start: DateTime(now.year, now.month - 1, now.day),
          end: now,
        );
      case PeriodFilter.year:
        return DateTimeRange(
          start: DateTime(now.year - 1, now.month, now.day),
          end: now,
        );
    }
  }

  // Future<void> _selectDateRange() async {
  //   final now = DateTime.now();
  //   final picked = await showDateRangePicker(
  //     context: context,
  //     firstDate: DateTime(now.year - 1),
  //     lastDate: DateTime(now.year + 1),
  //   );

  //   if (picked != null) {
  //     setState(() => selectedDateRange = picked);
  //     _loadStatistics();
  //   }
  // }

  void _onCategorySelected(String? categoryId) {
    setState(() => selectedCategoryId = categoryId);
    _loadStatistics();
  }

  void _onTypeChanged(EntryType type) {
    setState(() {
      selectedType = type;
      selectedCategoryId = null; // Limpiar la categoría seleccionada
    });
    _loadStatistics();
  }

  void _clearFilters() {
    setState(() {
      selectedCategoryId = null;
      selectedDateRange = null;
    });
    _loadStatistics();
  }

  @override
  Widget build(BuildContext context) {
    final categoryNames = getDefaultCategoriesByType(
      selectedType,
    ).map((cat) => cat['name'] as String).toList();

    return GenericScaffold(
      title: 'Estadísticas',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtro por período
           Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Theme.of(context).cardColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Filtro por período + tipo
      Row(
        children: [
          const Text('Periodo:'),
          const SizedBox(width: 8),
          DropdownButton<PeriodFilter>(
            value: selectedPeriod,
            items: const [
              DropdownMenuItem(value: PeriodFilter.week, child: Text('Semana')),
              DropdownMenuItem(value: PeriodFilter.month, child: Text('Mes')),
              DropdownMenuItem(value: PeriodFilter.year, child: Text('Año')),
            ],
            onChanged: (value) {
              setState(() {
                selectedPeriod = value!;
                selectedDateRange = _calculateDateRange(selectedPeriod);
              });
              _loadStatistics();
            },
          ),
          const Spacer(),
          ToggleButtons(
            isSelected: [
              selectedType == EntryType.expense,
              selectedType == EntryType.income,
            ],
            onPressed: (index) => _onTypeChanged(
              index == 0 ? EntryType.expense : EntryType.income,
            ),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Gastos'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Ingresos'),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 12),

      // Filtro por título
      TextField(
        decoration: const InputDecoration(
          labelText: 'Buscar por título',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          searchTitle = value;
          _loadStatistics();
        },
      ),

      const SizedBox(height: 12),

      // Filtro por categoría
      DropdownButtonFormField<String>(
        value: selectedCategoryId,
        decoration: const InputDecoration(
          labelText: 'Filtrar por categoría',
          border: OutlineInputBorder(),
        ),
        items: getDefaultCategoriesByType(selectedType)
            .map<DropdownMenuItem<String>>(
              (cat) => DropdownMenuItem<String>(
                value: cat['name'] as String,
                child: Text(cat['name']),
              ),
            )
            .toList(),
        onChanged: _onCategorySelected,
      ),

      const SizedBox(height: 8),

      Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          icon: const Icon(Icons.filter_alt_off),
          label: const Text('Limpiar filtros'),
          onPressed: _clearFilters,
        ),
      ),
    ],
  ),
),
const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<StatisticsBloc, StatisticsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.error != null) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  if (state.transactions.isEmpty) {
                    return const Center(child: Text('No hay transacciones.'));
                  }

                  return StatisticsContent(
                    transactions: state.transactions,
                    onDelete: (transactionModel) {
                      context.read<StatisticsBloc>().add(
                        DeleteTransaction(transaction: transactionModel),
                      );
                    },
                    onEdit: (transactionModel) {
                      context.push(
                        transactionModel.type == EntryType.income.toString()
                            ? AppRoutes.editIncome(transactionModel.id)
                            : AppRoutes.editExpense(transactionModel.id),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.deepPurple,
        children: [
          SpeedDialChild(
            backgroundColor: Theme.of(context).colorScheme.primary,
            labelBackgroundColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(color: Colors.white),
            child: const Icon(Icons.remove, color: Colors.white),
            label: 'Agregar gasto',
            onTap: () async {
              final result = await context.push(AppRoutes.addExpense());
              setState(() {
                selectedDateRange = _calculateDateRange(
                  selectedPeriod,
                ); // recalcular rango
              });
              if (result == true) {
                _loadStatistics();
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: Theme.of(context).colorScheme.primary,
            labelBackgroundColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(color: Colors.white),
            child: const Icon(Icons.add, color: Colors.white),
            label: 'Agregar ingreso',
            onTap: () async {
              final result = await context.push(AppRoutes.addIncome());
              setState(() {
                selectedDateRange = _calculateDateRange(
                  selectedPeriod,
                ); // recalcular rango
              });
              if (result == true) {
                _loadStatistics();
              }
            },
          ),
        ],
      ),
    );
  }
}
