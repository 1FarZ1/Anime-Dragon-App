import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 100,
      colors: true,
      printEmojis: true,
    ),
  );

  static void logDebug(dynamic message) => _logger.d(message);

  static void logError(dynamic message) => _logger.e(message);

  static void logWarning(dynamic message) => _logger.w(message);

  static void logInfo(dynamic message) => _logger.i(message);
}