class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Error del servidor']);
}