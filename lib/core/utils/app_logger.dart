import 'package:logger/logger.dart';

class AppLogger {
  static final _logger = Logger();

  static d(dynamic message) => _logger.d(message);

  static e(dynamic message) => _logger.e(message);

  static w(dynamic message) => _logger.w(message);

  static i(dynamic message) => _logger.i(message);
}
