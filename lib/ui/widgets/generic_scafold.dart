import 'package:flutter/material.dart';
import 'package:presupuestos/ui/widgets/generic_appbar.dart';
import 'package:presupuestos/ui/widgets/generic_gradient.dart';

/// Scaffold reutilizable que aplica gradiente y AppBar genérico.
class GenericScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;

  const GenericScaffold({
    super.key,
    this.title,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null ? GenericAppBar(title: title!) : null,
      body: GradientContainer(child: body),
      floatingActionButton: floatingActionButton,
    );
  }
}
