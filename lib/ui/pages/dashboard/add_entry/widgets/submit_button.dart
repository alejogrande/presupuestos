import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final bool isSubmitting;
  final bool enabled;
  final VoidCallback? onPressed;

  const SubmitButton({
    super.key,
    required this.label,
    required this.isSubmitting,
    this.enabled = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: enabled && !isSubmitting ? onPressed : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: isSubmitting
          ? CircularProgressIndicator(
              color: theme.colorScheme.onPrimary, // Asegúrate de pasar el theme
            )
          : Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }
}
