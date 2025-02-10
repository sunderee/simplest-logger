/// A lightweight, opinionated, colorful logging utility for Dart applications.
///
/// This library provides a simple yet powerful logging solution with minimal configuration
/// required. It features:
/// - Colorful console output with ANSI colors (can be disabled)
/// - Simple API with info, warning, and error levels
/// - Context-based logging with automatic class name detection
/// - Convenient mixin for class-based logging
/// - Stack trace support for error logging
///
/// Example usage:
/// ```dart
/// final logger = SimplestLogger('MyApp');
/// logger.init();
///
/// // Log different message types
/// logger.info('Application started');
/// logger.warning('Resource usage is high');
/// logger.error('Database error',
///   Exception('Connection failed'),
///   StackTrace.current
/// );
/// ```
library;

export './src/simplest_logger_instance.dart';
export './src/simplest_logger_level.dart';
export './src/simplest_logger_mixin.dart';
