import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_sdk/traccar_sdk.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;

  setUpAll(() async {
    client = await TestConfig.setup();
  });

  tearDownAll(() async => TestConfig.release());

  group('ReportsApi', skip: TestConfig.skipReason, () {
    final to = DateTime.now().toUtc();
    final from = to.subtract(const Duration(days: 7));

    test('getRouteSummary returns a list', () async {
      final summaries = await client.reports.getSummary(
        from: from,
        to: to,
      );
      expect(summaries, isList);
    });

    test('getEvents returns a list', () async {
      final events = await client.reports.getEvents(
        from: from,
        to: to,
      );
      expect(events, isList);
    });

    test('getRoute returns a list of positions', () async {
      final positions = await client.reports.getRoute(
        from: from,
        to: to,
      );
      expect(positions, isList);
    });

    test('getTrips returns a list', () async {
      final trips = await client.reports.getTrips(
        from: from,
        to: to,
      );
      expect(trips, isList);
    });

    test('getStops returns a list', () async {
      final stops = await client.reports.getStops(
        from: from,
        to: to,
      );
      expect(stops, isList);
    });

    test('getGeofenceIntervals returns a list', () async {
      try {
        final geos = await client.reports.getGeofenceIntervals(
          from: from,
          to: to,
        );
        expect(geos, isList);
      } on TraccarException catch (e) {
        // Some Traccar builds route /reports/geofences differently; skip if absent.
        if (e.isNotFound) return;
        rethrow;
      }
    });
  });
}
