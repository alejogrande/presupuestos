import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presupuestos/core/router/routes.dart';
import 'package:presupuestos/ui/widgets/generic_scafold.dart';
import 'bloc/register_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => RegisterBloc(FirebaseAuth.instance),
      child: GenericScaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ), // espacio lateral
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: BlocConsumer<RegisterBloc, RegisterState>(
                  listenWhen: (previous, current) =>
                      previous.isSuccess != current.isSuccess &&
                      current.isSuccess,
                  listener: (context, state) {
                    context.go(AppRoutes.login);
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Registrarse',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => context
                              .read<RegisterBloc>()
                              .add(RegisterEmailChanged(value)),
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            prefixIcon: Icon(
                              Icons.email,
                              color: theme.colorScheme.primary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          obscureText: true,
                          onChanged: (value) => context
                              .read<RegisterBloc>()
                              .add(RegisterPasswordChanged(value)),
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: theme.colorScheme.primary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (state.errorMessage != null)
                          Text(
                            state.errorMessage!,
                            style: TextStyle(color: theme.colorScheme.error),
                          ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: state.isSubmitting
                                ? null
                                : () => context.read<RegisterBloc>().add(
                                    RegisterSubmitted(),
                                  ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state.isSubmitting
                                ? CircularProgressIndicator(
                                    color: theme.colorScheme.onPrimary,
                                  )
                                : const Text(
                                    'Registrarse',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => context.go(AppRoutes.login),
                          child: Text(
                            "¿Ya tienes una cuenta? Inicia sesión",
                            style: TextStyle(color: theme.colorScheme.primary),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
