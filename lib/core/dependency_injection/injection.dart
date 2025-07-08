import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:presupuestos/data/datasource/firebase_auth_datasource.dart';
import 'package:presupuestos/data/enums/entry_type.dart';
import 'package:presupuestos/data/repositories/auth_repository_impl.dart';
import 'package:presupuestos/domain/repositories/auth_repository.dart';
import 'package:presupuestos/data/repositories/transaction_repository_impl.dart';
import 'package:presupuestos/domain/repositories/transaction_repository.dart';
import 'package:presupuestos/domain/use_cases/auth_use_cases.dart';
import 'package:presupuestos/ui/pages/auth/login/bloc/login_bloc.dart';
import 'package:presupuestos/ui/pages/auth/register/bloc/register_bloc.dart';
import 'package:presupuestos/data/datasource/firebase_transaction_datasource.dart';
import 'package:presupuestos/domain/use_cases/transaction_use_cases.dart';
import 'package:presupuestos/ui/pages/dashboard/add_entry/bloc/add_entry_bloc.dart';
import 'package:presupuestos/ui/pages/dashboard/statistics/bloc/statistics_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => http.Client());

  //  DataSources
  locator.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(locator()),
  );

  locator.registerLazySingleton<FirebaseTransactionDataSource>(
    () => FirebaseTransactionDataSourceImpl(locator()),
  );

  //  Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(locator()),
  );

  //  UseCases
  locator.registerLazySingleton(() => AuthUseCases(locator()));
  locator.registerLazySingleton(() => TransactionUseCases(locator()));

  //  BLoCs
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => RegisterBloc(locator()));
  locator.registerFactoryParam<AddEntryBloc, EntryType, void>(
    (entryType, _) => AddEntryBloc(
      transactionUseCases: locator(),
      entryType: entryType,
      authUseCases: locator(),
    ),
  );
  locator.registerFactory(
    () =>
        StatisticsBloc(transactionUseCases: locator(), authUseCases: locator()),
  );
}
