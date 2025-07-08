import 'package:flutter/material.dart';

/// Un contenedor reutilizable con gradiente de fondo.
class GradientContainer extends StatelessWidget {
  final Widget child;
  const GradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topColor = theme.colorScheme.primary.withValues(alpha: 0.3);
    final bottomColor = theme.colorScheme.primaryContainer.withValues(
      alpha: 0.1,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [topColor, bottomColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
