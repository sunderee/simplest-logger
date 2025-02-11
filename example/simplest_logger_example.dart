import 'package:simplest_logger/simplest_logger.dart';

class TestService with SimplestLoggerMixin {
  String performAction(bool shouldSucceed) {
    try {
      logger.info('Starting action');
      if (!shouldSucceed) {
        throw Exception('Test error');
      }

      logger.info('Action completed successfully');
      return 'Success';
    } catch (error, stackTrace) {
      logger.error('Action failed', error, stackTrace);
      rethrow;
    }
  }
}

void main() {
  // Create a logger instance with a context
  const logger = SimplestLogger('main');

  // Log messages with default configuration (all levels enabled, colors on)
  logger.info('This is an info message');
  logger.warning('This is a warning message');
  logger.error('This is an error message');

  // Disable all logging globally
  SimplestLogger.setLevel(SimplestLoggerLevel.none);
  logger.info('This message will not appear');

  // Re-enable logging and configure colors
  SimplestLogger.setLevel(SimplestLoggerLevel.all);
  SimplestLogger.useColors(false);
  logger.warning('This warning message is without colors');

  // Re-enable colors
  SimplestLogger.useColors(true);

  // Example using the mixin
  final testService = TestService();
  try {
    testService.performAction(false); // This will throw
  } catch (_) {
    // Ignore the error for the example
  }
  testService.performAction(true);
}
