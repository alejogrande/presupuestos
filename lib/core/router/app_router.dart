import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presupuestos/core/dependency_injection/injection.dart';
import 'package:presupuestos/ui/pages/auth/login/bloc/login_bloc.dart';
import 'package:presupuestos/ui/pages/auth/login/login_screen.dart';
import 'package:presupuestos/ui/pages/auth/register/register_page.dart';
import 'package:presupuestos/ui/pages/dashboard/add_entry/add_entry_page.dart';
import 'package:presupuestos/ui/pages/dashboard/add_entry/bloc/add_entry_bloc.dart';
import 'package:presupuestos/ui/pages/dashboard/statistics/bloc/statistics_bloc.dart';
import 'package:presupuestos/ui/pages/dashboard/statistics/statistics_page.dart';
import 'routes.dart';
import 'routing_utils.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => BlocProvider(
        create: (_) => locator<LoginBloc>(),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: AppRoutes.addEntry,
      name: 'add_entry',
      builder: (context, state) {
        final typeParam = state.uri.queryParameters['type'];
        final bool isEdit = state.uri.queryParameters['isEdit'] == "true"
            ? true
            : false;
        final type = mapStringToEntryType(
          typeParam,
        ); // puede ser null si no existe o no mapea
        return BlocProvider(
          create: (_) => locator<AddEntryBloc>(param1: type),
          child: AddEntryPage(type: type, isEdit: isEdit),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.statistics,
      name: 'statistics',
      builder: (context, state) => BlocProvider(
        create: (_) => locator<StatisticsBloc>(),
        child: const StatisticsPage(),
      ),
    ),
  ],
);
