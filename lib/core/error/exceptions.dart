// core/error/exceptions.dart

/// Base class for all Exceptions in the application
class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class ServerException extends CustomException {
  ServerException(super.message);
}

class CacheException extends CustomException {
  CacheException(super.message);
}
