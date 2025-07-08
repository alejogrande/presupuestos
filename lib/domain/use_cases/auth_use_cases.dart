import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presupuestos/data/failure.dart';
import 'package:presupuestos/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository repository;

  AuthUseCases(this.repository);

  Future<Either<Failure, User>> login(String email, String password) {
    return repository.login(email, password);
  }

  Future<Either<Failure, User>> register(String email, String password) {
    return repository.register(email, password);
  }

  Future<void> logout() {
    return repository.logout();
  }

  User? getCurrentUser() {
    return repository.getCurrentUser();
  }
}