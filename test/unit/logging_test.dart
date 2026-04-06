import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:traccar_sdk/traccar_sdk.dart';

void main() {
  setUp(() {
    // Reset to none before each test.
    TraccarLogger.logLevel = TraccarLogLevel.none;
  });

  group('TraccarLogLevel', () {
    test('enum has all expected values', () {
      expect(
        TraccarLogLevel.values.map((e) => e.name),
        containsAll(['none', 'error', 'warning', 'info', 'verbose']),
      );
    });
  });

  group('TraccarLogger', () {
    test('logLevel defaults to none', () {
      expect(TraccarLogger.logLevel, TraccarLogLevel.none);
    });

    test('setting logLevel changes value', () {
      TraccarLogger.logLevel = TraccarLogLevel.info;
      expect(TraccarLogger.logLevel, TraccarLogLevel.info);
    });

    test('onRecord emits nothing when level is none', () async {
      TraccarLogger.logLevel = TraccarLogLevel.none;
      final records = <LogRecord>[];
      final sub = TraccarLogger.onRecord.listen(records.add);

      // Allow any pending microtasks to flush.
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(records, isEmpty);
    });

    test('onRecord emits when level is verbose and logRequest called', () async {
      TraccarLogger.logLevel = TraccarLogLevel.verbose;

      final records = <LogRecord>[];
      final sub = TraccarLogger.onRecord.listen(records.add);

      TraccarLogger.logRequest('GET', 'http://localhost/api/devices', {}, {});

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(records, isNotEmpty);
    });

    test('logError emits SEVERE record', () async {
      TraccarLogger.logLevel = TraccarLogLevel.error;

      final records = <LogRecord>[];
      final sub = TraccarLogger.onRecord.listen(records.add);

      TraccarLogger.logError('connection refused');

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(records.any((r) => r.level == Level.SEVERE), isTrue);
    });

    test('resetting logLevel to none suppresses records', () async {
      TraccarLogger.logLevel = TraccarLogLevel.verbose;
      TraccarLogger.logLevel = TraccarLogLevel.none;

      final records = <LogRecord>[];
      final sub = TraccarLogger.onRecord.listen(records.add);

      TraccarLogger.logRequest('GET', 'http://localhost/', {}, {});
      TraccarLogger.logError('should not appear');

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(records, isEmpty);
    });
  });
}
