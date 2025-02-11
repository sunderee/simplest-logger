import 'package:logging/logging.dart';
import 'package:simplest_logger/src/simplest_logger_internal.dart';
import 'package:simplest_logger/src/simplest_logger_level.dart';

/// Global configuration for SimplestLogger.
///
/// This class manages global settings and initialization for the logging system.
/// It ensures that logging is properly initialized before any logging calls are made.
final class SimplestLoggerConfig {
  static SimplestLoggerConfig? _instance;

  /// Gets the singleton instance of [SimplestLoggerConfig].
  static SimplestLoggerConfig get instance =>
      _instance ??= SimplestLoggerConfig._();

  /// Whether the logger has been initialized.
  bool _isInitialized = false;

  /// Private constructor to enforce singleton pattern.
  SimplestLoggerConfig._() {
    _initialize();
  }

  /// Initializes the logging system if it hasn't been initialized yet.
  void _initialize() {
    if (_isInitialized) return;

    SimplestLoggerInternal.instance();
    _isInitialized = true;
  }

  /// Sets the minimum logging level.
  void setLevel(SimplestLoggerLevel level) {
    Logger.root.level = switch (level) {
      SimplestLoggerLevel.all => Level.ALL,
      SimplestLoggerLevel.none => Level.OFF,
    };
  }

  /// Controls whether log messages are colored using ANSI color codes.
  void useColors(bool useColors) {
    SimplestLoggerInternal.instance().useColors(useColors);
  }
}
