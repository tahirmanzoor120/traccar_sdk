// Shared JSON coercion helpers used by json_serializable-generated code.
// ignore_for_file: prefer_expression_function_bodies

/// Coerces a JSON [num] (int or double) to [double]. Handles `0` → `0.0`.
double? doubleFromJson(dynamic v) =>
    v == null ? null : (v as num).toDouble();

/// Coerces a JSON [num] to [int]. Handles `1.0` → `1`.
int? intFromJson(dynamic v) =>
    v == null ? null : (v as num).toInt();

/// Coerces a JSON list of numbers to [List<int>].
List<int>? intListFromJson(dynamic v) => v == null
    ? null
    : List<int>.unmodifiable(
        (v as List<dynamic>).map<int>((e) => (e as num).toInt()),
      );
