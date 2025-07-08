import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presupuestos/core/utils/category_utils.dart';
import 'package:presupuestos/data/enums/entry_type.dart';
import 'package:presupuestos/ui/pages/dashboard/add_entry/bloc/add_entry_event.dart';
import 'package:presupuestos/ui/pages/dashboard/add_entry/widgets/title_input.dart';
import 'package:presupuestos/ui/pages/dashboard/statistics/bloc/statistics_bloc.dart';
import 'package:presupuestos/ui/widgets/generic_scafold.dart';
import 'bloc/add_entry_bloc.dart';
import 'bloc/add_entry_state.dart';
import 'widgets/amount_input.dart';
import 'widgets/category_selector.dart';
import 'widgets/date_selector.dart';
import 'widgets/comment_input.dart';
import 'widgets/submit_button.dart';

class AddEntryPage extends StatelessWidget {
  final EntryType type;
  final bool isEdit;
  final String? entryId;

  const AddEntryPage({
    super.key,
    required this.type,
    this.isEdit = false,
    this.entryId,
  });

  @override
  Widget build(BuildContext context) {
    // Categorías de ejemplo, mas adelante las paso a firebase
    final categories = getDefaultCategoriesByType(type);
    final title = isEdit == true
        ? (type == EntryType.income ? 'Editar ingreso' : 'Editar gasto')
        : (type == EntryType.income ? 'Agregar ingreso' : 'Agregar gasto');
    final submitLabel = isEdit
        ? (type == EntryType.income ? 'Guardar ingreso' : 'Guardar gasto')
        : (type == EntryType.income ? 'Agregar ingreso' : 'Agregar gasto');

    final bloc = context.read<AddEntryBloc>();
    if (bloc.state.category.trim().isEmpty) {
      final defaultCategory = categories[0]['name']?.toString() ?? '';
      bloc.add(CategoryChanged(defaultCategory));
    }
    return GenericScaffold(
      title: title,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: BlocBuilder<AddEntryBloc, AddEntryState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  TitleInput(title: state.title),
                  const SizedBox(height: 16),
                  AmountInput(amount: state.amount),
                  const SizedBox(height: 16),
                  CategorySelector(
                    categories: categories,
                    selectedCategory: state.category.isEmpty
                        ? (categories[0]['name']?.toString() ?? '')
                        : state.category,
                  ),
                  const SizedBox(height: 16),
                  DateSelector(selectedDate: state.date),
                  const SizedBox(height: 16),
                  CommentInput(comment: state.descripcion),
                  const SizedBox(height: 24),
                  BlocListener<AddEntryBloc, AddEntryState>(
                    listenWhen: (previous, current) =>
                        current.isSuccess && !previous.isSuccess,
                    listener: (context, state) {
                      // Mostrar el toast arriba
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Agregado con éxito'),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                            right: 16,
                          ),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 2),
                        ),
                      );

                      // Lanzar evento al StatisticsBloc
                      context.read<StatisticsBloc>().add(
                        LoadStatistics(
                          entryType: type, // Este `type` viene de AddEntryPage
                        ),
                      );

                      // // Volver atrás si quieres
                      
                    },
                    child: SubmitButton(
                      label: submitLabel,
                      isSubmitting: state.isSubmitting,
                      enabled: state.isValid,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<AddEntryBloc>().add(SubmitEntry());
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
