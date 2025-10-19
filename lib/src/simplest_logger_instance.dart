import 'package:logging/logging.dart';
import 'package:simplest_logger/src/simplest_logger_config.dart';
import 'package:simplest_logger/src/simplest_logger_level.dart';

/// A logger instance that provides methods for logging messages with different severity levels.
///
/// Each logger instance is associated with a specific [context] that helps identify
/// the source of log messages. The context is typically a class name or a module name.
///
/// Example:
/// ```dart
/// final logger = SimplestLogger('MyClass');
/// logger.info('Operation started');
/// ```
final class SimplestLogger {
  /// The context identifier for this logger instance.
  ///
  /// This value appears in all log messages from this instance to help identify
  /// the source of the message.
  final String context;

  /// Creates a new logger instance with the specified [context].
  ///
  /// The [context] parameter is typically a class name or module name that helps
  /// identify where the log message originated from.
  const SimplestLogger(this.context);

  /// Sets the minimum logging level.
  ///
  /// Use this to control which messages get logged:
  /// - [SimplestLoggerLevel.all] enables all logging
  /// - [SimplestLoggerLevel.none] disables all logging
  static void setLevel(SimplestLoggerLevel level) {
    SimplestLoggerConfig.instance.setLevel(level);
  }

  /// Controls whether log messages are colored using ANSI color codes.
  ///
  /// Set [useColors] to `false` to disable colored output, which might be necessary
  /// when logging to a file or when the terminal doesn't support ANSI colors.
  static void useColors(bool useColors) {
    SimplestLoggerConfig.instance.useColors(useColors);
  }

  /// Logs an informational message.
  ///
  /// Use this for general information about application progress and normal operations.
  /// Messages are displayed in green when colors are enabled.
  void info(String message) {
    Logger(context).log(Level.INFO, message);
  }

  /// Logs a warning message.
  ///
  /// Use this for potentially harmful situations or warnings that don't prevent
  /// the application from working but might indicate problems.
  /// Messages are displayed in yellow when colors are enabled.
  void warning(String message) {
    Logger(context).log(Level.WARNING, message);
  }

  /// Logs an error message with optional error object and stack trace.
  ///
  /// Use this for error conditions that prevent normal operation but don't
  /// necessarily crash the application.
  /// Messages are displayed in red when colors are enabled.
  ///
  /// Parameters:
  /// - [message]: The error message to log
  /// - [error]: Optional error object providing more details about the error
  /// - [stackTrace]: Optional stack trace showing where the error occurred
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    Logger(context).log(Level.SEVERE, message, error, stackTrace);
  }
}
