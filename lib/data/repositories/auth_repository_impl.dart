import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presupuestos/core/helpers/firebase_helper.dart';
import 'package:presupuestos/data/datasource/firebase_auth_datasource.dart';
import 'package:presupuestos/data/failure.dart';
import 'package:presupuestos/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) {
    return handleEither(() => authDataSource.login(email, password));
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) {
    return handleEither(() => authDataSource.register(email, password));
  }

  @override
  Future<void> logout() async => await authDataSource.logout();

  @override
  User? getCurrentUser() => authDataSource.getCurrentUser();
}
