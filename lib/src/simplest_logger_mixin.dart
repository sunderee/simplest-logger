import 'package:simplest_logger/src/simplest_logger_instance.dart';

/// A mixin that provides convenient access to a [SimplestLogger] instance.
///
/// This mixin automatically creates a logger instance using the class name as the context.
/// It's particularly useful for classes that need to do logging throughout their implementation.
///
/// Example:
/// ```dart
/// class UserService with SimplestLoggerMixin {
///   void createUser() {
///     logger.info('Creating new user');
///     // ... implementation ...
///     logger.info('User created successfully');
///   }
/// }
/// ```
mixin SimplestLoggerMixin {
  /// The logger instance for this class.
  ///
  /// The context is automatically set to the runtime type name of the class.
  SimplestLogger get logger => SimplestLogger(runtimeType.toString());
}
