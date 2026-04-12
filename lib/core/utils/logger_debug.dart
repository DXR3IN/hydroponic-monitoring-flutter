import 'package:logger/logger.dart';

class LoggerDebug {
  static final LoggerDebug _instance = LoggerDebug._internal();
  
  static LoggerDebug get instance => _instance;

  late final Logger _logger;

  LoggerDebug._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        errorMethodCount: 3, 
        lineLength: 80, 
        colors: true, 
        printEmojis: true,
        printTime: true,
      ),
      level: Level.debug, 
    );
  }

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Mencatat log level Info (Informasi umum, misalnya navigasi atau event)
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Mencatat log level Warning (Masalah potensial yang tidak fatal)
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Mencatat log level Error (Kegagalan aplikasi yang serius atau Exception)
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Mencatat log level Fatal (Kegagalan yang menyebabkan crash)
  void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// Mencatat log level Trace (Informasi sangat detail, jarang digunakan)
  void t(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }
}