import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:presupuestos/data/exception.dart';
import 'package:presupuestos/data/failure.dart';

/// Ejecuta una operación asíncrona y convierte errores comunes en Failures.
Future<Either<Failure, T>> handleEither<T>(Future<T> Function() operation) async {
  try {
    final result = await operation();
    return Right(result);
  }

  // Errores personalizados del dominio o backend
  on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  }

  // Errores comunes de red
  on SocketException {
    return const Left(ConnectionFailure('No hay conexión a internet'));
  }

  // Errores de Firebase Auth
  on FirebaseAuthException catch (e) {
    return Left(_mapFirebaseAuthError(e));
  }

  // Errores de Firebase Firestore u otros Firebase
  on FirebaseException catch (e) {
    return Left(FirestoreFailure(e.message ?? 'Error de Firebase'));
  }

  // Errores de plataforma (ej. permisos, canal de plataforma)
  on PlatformException catch (e) {
    return Left(PlatformFailure(e.message ?? 'Error de plataforma'));
  }

  // Errores inesperados
  catch (e) {
    return Left(UnknownFailure('Error inesperado: ${e.toString()}'));
  }
}

/// Mapea errores comunes de FirebaseAuth a mensajes más entendibles.
Failure _mapFirebaseAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return const AuthFailure('Correo inválido');
    case 'user-disabled':
      return const AuthFailure('Usuario deshabilitado');
    case 'user-not-found':
      return const AuthFailure('Usuario no encontrado');
    case 'wrong-password':
      return const AuthFailure('Contraseña incorrecta');
    case 'email-already-in-use':
      return const AuthFailure('El correo ya está en uso');
    case 'operation-not-allowed':
      return const AuthFailure('Operación no permitida');
    case 'weak-password':
      return const AuthFailure('Contraseña muy débil');
    case 'invalid-credential':
      return const AuthFailure('Credenciales inválidas o expiradas');
    default:
      return AuthFailure(e.message ?? 'Error de autenticación desconocido');
  }
}

// Clase para representar errores de Firestore
class FirestoreFailure extends Failure {
  const FirestoreFailure(super.message);
}
