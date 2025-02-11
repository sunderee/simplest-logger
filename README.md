# simplest_logger

A lightweight, opinionated, colorful logging utility for Dart applications. Minimal configuration necessary.

## Features

- Colorful output with ANSI colors (can be disabled)
- Simple API with info, warning, and error levels
- Context-based logging with automatic class name detection
- Zero configuration required - works out of the box
- Convenient mixin for class-based logging
- Stack trace support for error logging
- Global configuration for consistent logging across your application

## Installation

Add `simplest_logger` to your `pubspec.yaml`:

```yaml
dependencies:
  simplest_logger: ^1.0.2
```

Then run:

```bash
dart pub get
```

## Usage

### Basic Usage

```dart
import 'package:simplest_logger/simplest_logger.dart';

void main() {
  // Create a logger instance with a context
  final logger = SimplestLogger('MyApp');
  
  // Log messages
  logger.info('Application started');
  logger.warning('Resource usage is high');
  logger.error('Failed to connect to database', 
    Exception('Connection timeout'), 
    StackTrace.current
  );
}
```

### Using the Mixin

For class-based logging, use the `SimplestLoggerMixin`:

```dart
import 'package:simplest_logger/simplest_logger.dart';

class MyService with SimplestLoggerMixin {
  void doSomething() {
    logger.info('Starting operation');
    // Your code here
    logger.info('Operation completed');
  }
}
```

### Configuration

All configuration is done through static methods on `SimplestLogger`, affecting all logger instances globally.

#### Log Levels

Control logging output with log levels:

```dart
// Turn off all logging globally
SimplestLogger.setLevel(SimplestLoggerLevel.none);

// Enable all logging globally
SimplestLogger.setLevel(SimplestLoggerLevel.all);
```

#### Color Output

Enable or disable ANSI color output:

```dart
// Disable colors globally
SimplestLogger.useColors(false);

// Enable colors globally
SimplestLogger.useColors(true);
```

## Output Format

The logger produces output in the following format:

```
LEVEL TIMESTAMP [CONTEXT] MESSAGE
```

For errors, additional information is included:

```
LEVEL TIMESTAMP [CONTEXT] MESSAGE
Error: ERROR_DETAILS
Stack trace:
STACK_TRACE
```

Colors are applied as follows:
- INFO: Green
- WARNING: Yellow
- ERROR: Red

## License

MIT License - feel free to use this package in your projects.