import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presupuestos/core/dependency_injection/injection.dart';
import 'package:presupuestos/domain/use_cases/auth_use_cases.dart';


class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GenericAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final authUseCases = locator<AuthUseCases>();
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      leading: canPop
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(true),
            )
          : null,
      title: Text(title),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'logout') {
              await authUseCases.logout();
              if (context.mounted) context.go('/login');
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: 'logout',
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ],
    );
  }
}
