abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class PlatformFailure extends Failure {
  const PlatformFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
