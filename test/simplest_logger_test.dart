import 'dart:async';

import 'package:simplest_logger/simplest_logger.dart';
import 'package:test/test.dart';

void main() {
  group('SimplestLogger', () {
    late SimplestLogger logger;
    late StringBuffer output;
    late Zone testZone;

    setUp(() {
      logger = const SimplestLogger('TestContext');
      output = StringBuffer();

      // Create a test zone to capture print output
      testZone = Zone.current.fork(
        specification: ZoneSpecification(
          print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
            output.writeln(line);
          },
        ),
      );
    });

    tearDown(() {
      output.clear();
    });

    test('initialization sets up the logger correctly', () {
      testZone.run(() {
        logger.init();
        logger.info('Test message');
        expect(output.toString(), contains('TestContext'));
        expect(output.toString(), contains('Test message'));
      });
    });

    test('setLevel changes logging level correctly', () {
      testZone.run(() {
        logger.init();

        // Set level to none
        logger.setLevel(SimplestLoggerLevel.none);
        logger.info('Should not appear');
        expect(output.toString(), isEmpty);

        // Set level back to all
        logger.setLevel(SimplestLoggerLevel.all);
        logger.info('Should appear');
        expect(output.toString(), contains('Should appear'));
      });
    });

    test('useColors controls ANSI color output', () {
      testZone.run(() {
        logger.init();

        // Test with colors
        logger.useColors(true);
        logger.info('Colored message');
        expect(output.toString(), contains('\u001b['));

        output.clear();

        // Test without colors
        logger.useColors(false);
        logger.info('Non-colored message');
        expect(output.toString(), isNot(contains('\u001b[')));
      });
    });

    test('different log levels produce appropriate output', () {
      testZone.run(() {
        logger.init();

        logger.info('Info message');
        expect(output.toString(), contains('INFO'));
        expect(output.toString(), contains('Info message'));

        output.clear();

        logger.warning('Warning message');
        expect(output.toString(), contains('WARNING'));
        expect(output.toString(), contains('Warning message'));

        output.clear();

        logger.error('Error message');
        expect(output.toString(), contains('SEVERE'));
        expect(output.toString(), contains('Error message'));
      });
    });

    test('error logging includes error and stack trace', () {
      testZone.run(() {
        logger.init();

        final error = Exception('Test error');
        final stackTrace = StackTrace.current;

        logger.error('Error occurred', error, stackTrace);
        expect(output.toString(), contains('Error occurred'));
        expect(output.toString(), contains('Exception: Test error'));
      });
    });

    test('SimplestLoggerMixin provides correct logger instance', () {
      final testInstance = TestClass();
      expect(testInstance.logger, isA<SimplestLogger>());
      expect(testInstance.logger.context, equals('TestClass'));
    });
  });
}

class TestClass with SimplestLoggerMixin {}
