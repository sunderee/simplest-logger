import 'dart:async';

import 'package:logging/logging.dart';
import 'package:simplest_logger/simplest_logger.dart';
import 'package:test/test.dart';

void main() {
  group('SimplestLogger', () {
    late SimplestLogger logger;
    late StringBuffer output;
    late StreamSubscription<LogRecord> subscription;

    setUp(() {
      // Reset global configuration to known state
      SimplestLogger.setLevel(SimplestLoggerLevel.all);
      SimplestLogger.useColors(true);

      logger = const SimplestLogger('TestContext');
      output = StringBuffer();

      // Listen to log records directly
      subscription = Logger.root.onRecord.listen((record) {
        output.writeln(
            '[${record.level}] ${record.loggerName}: ${record.message}');
        if (record.error != null) {
          output.writeln('Error: ${record.error}');
        }
        if (record.stackTrace != null) {
          output.writeln('Stack trace:\n${record.stackTrace}');
        }
      });
    });

    tearDown(() {
      output.clear();
      subscription.cancel();
    });

    test('logger works without explicit initialization', () async {
      logger.info('Test message');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), contains('TestContext'));
      expect(output.toString(), contains('Test message'));
    });

    test('global configuration through static methods works correctly',
        () async {
      // Set level to none
      SimplestLogger.setLevel(SimplestLoggerLevel.none);
      logger.info('Should not appear');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), isEmpty);

      // Set level back to all
      SimplestLogger.setLevel(SimplestLoggerLevel.all);
      logger.info('Should appear');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), contains('Should appear'));
    });

    test('global color configuration works correctly', () async {
      // Test with colors
      SimplestLogger.useColors(true);
      logger.info('Colored message');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), contains('INFO'));

      output.clear();

      // Test without colors
      SimplestLogger.useColors(false);
      logger.info('Non-colored message');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), contains('INFO'));
    });

    test('different log levels produce appropriate output', () async {
      logger.info('Info message');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), contains('INFO'));
      expect(output.toString(), contains('Info message'));

      output.clear();

      logger.warning('Warning message');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), contains('WARNING'));
      expect(output.toString(), contains('Warning message'));

      output.clear();

      logger.error('Error message');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), contains('SEVERE'));
      expect(output.toString(), contains('Error message'));
    });

    test('error logging includes error and stack trace', () async {
      final error = Exception('Test error');
      final stackTrace = StackTrace.current;

      logger.error('Error occurred', error, stackTrace);
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), contains('Error occurred'));
      expect(output.toString(), contains('Exception: Test error'));
      expect(output.toString(), contains('Stack trace:'));
    });

    test('SimplestLoggerMixin provides correct logger instance', () {
      final testInstance = TestClass();
      expect(testInstance.logger, isA<SimplestLogger>());
      expect(testInstance.logger.context, equals('TestClass'));
    });

    test('multiple logger instances share the same configuration', () async {
      const logger1 = SimplestLogger('Logger1');
      const logger2 = SimplestLogger('Logger2');

      // Both loggers should respect global color setting
      SimplestLogger.useColors(true);
      logger1.info('Message 1');
      logger2.info('Message 2');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), contains('Logger1'));
      expect(output.toString(), contains('Logger2'));

      output.clear();

      // Both loggers should respect global level setting
      SimplestLogger.setLevel(SimplestLoggerLevel.none);
      logger1.info('Should not appear 1');
      logger2.info('Should not appear 2');
      await Future<void>.delayed(Duration.zero);
      expect(output.toString(), isEmpty);
    });
  });
}

class TestClass with SimplestLoggerMixin {}
