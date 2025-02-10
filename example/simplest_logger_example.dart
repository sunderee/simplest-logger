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
  const logger = SimplestLogger('main');
  logger.init();

  logger.info('This is an info message');
  logger.warning('This is a warning message');
  logger.error('This is an error message');

  logger.setLevel(SimplestLoggerLevel.none);
  logger.info('This is an info message (should not be printed)');

  logger.setLevel(SimplestLoggerLevel.all);
  logger.useColors(false);
  logger.warning('This warning message is without colors');

  logger.useColors(true);

  final testService = TestService();
  testService.performAction(false);
  testService.performAction(true);
}
