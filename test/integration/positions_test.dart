import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_sdk/traccar_sdk.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;

  setUpAll(() async {
    client = await TestConfig.setup();
  });

  tearDownAll(() async => TestConfig.release());

  group('PositionsApi', skip: TestConfig.skipReason, () {
    test('getPositions returns a list', () async {
      final positions = await client.positions.getPositions();
      expect(positions, isList);
    });

    test('getPositions with date range works', () async {
      final now = DateTime.now().toUtc();
      final from = now.subtract(const Duration(days: 1));
      final positions = await client.positions.getPositions(
        from: from,
        to: now,
      );
      expect(positions, isList);
    });
  });
}
