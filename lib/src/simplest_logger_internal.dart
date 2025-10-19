import 'package:logging/logging.dart';

/// Internal implementation of the logging system.
///
/// This class handles the actual logging implementation, including color management
/// and log message formatting. It's not intended to be used directly by consumers
/// of the library.
final class SimplestLoggerInternal {
  // ANSI codes for text coloring.
  /// ANSI code to reset text formatting
  static const String _reset = '\u001b[0m';

  /// ANSI code for green text (used for info messages)
  static const String _green = '\u001b[32m';

  /// ANSI code for yellow text (used for warning messages)
  static const String _yellow = '\u001b[33m';

  /// ANSI code for red text (used for error messages)
  static const String _red = '\u001b[31m';

  /// ANSI code for blue text (used for debug messages)
  static const String _blue = '\u001b[34m';

  /// ANSI code for white text (used for unknown levels)
  static const String _white = '\u001b[37m';

  static SimplestLoggerInternal? _instance;

  /// Returns the singleton instance of [SimplestLoggerInternal].
  ///
  /// Creates the instance if it doesn't exist yet.
  static SimplestLoggerInternal instance() =>
      _instance ??= SimplestLoggerInternal._();

  /// Whether to use ANSI colors in log output.
  bool _useColors = true;

  /// Creates a new instance and sets up logging handlers.
  ///
  /// This constructor is private to enforce the singleton pattern.
  SimplestLoggerInternal._() {
    _handleLogging();
  }

  /// Controls whether log messages should use ANSI colors.
  void useColors(bool useColors) {
    _useColors = useColors;
  }

  /// Sets up the logging handler that processes and formats log records.
  void _handleLogging() {
    Logger.root.onRecord.listen((record) {
      final timestamp = record.time.toIso8601String();
      final context = record.loggerName;
      final message = record.message;
      final level = record.level;
      final error = record.error;
      final stackTrace = record.stackTrace;

      var logMessage = '$level $timestamp [$context] $message';
      if (error != null) {
        logMessage += '\nError: $error';
      }
      if (stackTrace != null) {
        logMessage += '\nStack trace:\n$stackTrace';
      }

      if (_useColors) {
        final startColor = _colorFromLevel(level);
        print('$startColor$logMessage$_reset');
      } else {
        print(logMessage);
      }
    });
  }

  /// Maps logging levels to ANSI color codes.
  String _colorFromLevel(Level level) => switch (level) {
    Level.ALL => _blue,
    Level.INFO => _green,
    Level.WARNING => _yellow,
    Level.SEVERE => _red,
    _ => _white,
  };
}
