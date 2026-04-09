import 'dart:convert';

import 'package:test/test.dart';
import 'package:traccar_sdk/traccar_sdk.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;
  int? createdId;

  setUpAll(() async {
    client = await TestConfig.setup();
  });

  tearDownAll(() async {
    if (createdId != null) {
      await client.calendars.deleteCalendar(createdId!);
    }
    await TestConfig.release();
  });

  group('CalendarsApi', skip: TestConfig.skipReason, () {
    test('getCalendars returns a list', () async {
      final list = await client.calendars.getCalendars();
      expect(list, isList);
    });

    test('createCalendar stores a calendar', () async {
      // Minimal iCal data (single all-day event).
      const ical =
          'BEGIN:VCALENDAR\r\n'
          'VERSION:2.0\r\n'
          'BEGIN:VEVENT\r\n'
          'DTSTART;VALUE=DATE:20240101\r\n'
          'DTEND;VALUE=DATE:20240102\r\n'
          'SUMMARY:Test\r\n'
          'END:VEVENT\r\n'
          'END:VCALENDAR';
      // Traccar stores calendars as base64-encoded iCal.
      final encoded = base64Encode(utf8.encode(ical));

      final calendar = Calendar(name: 'Test Calendar', data: encoded);
      final created = await client.calendars.createCalendar(calendar);
      expect(created.id, isNotNull);
      expect(created.name, 'Test Calendar');
      createdId = created.id;
    });

    test('updateCalendar changes name', () async {
      final existing = (await client.calendars.getCalendars()).firstWhere(
        (c) => c.id == createdId,
      );
      final updated = await client.calendars.updateCalendar(
        createdId!,
        existing.copyWith(name: 'Renamed Calendar'),
      );
      expect(updated.name, 'Renamed Calendar');
    });

    test('deleteCalendar removes it', () async {
      await client.calendars.deleteCalendar(createdId!);
      final list = await client.calendars.getCalendars();
      expect(list.any((c) => c.id == createdId), isFalse);
      createdId = null;
    });
  });
}
