import 'dart:io';

import 'package:traccar_sdk/traccar_sdk.dart';

/// Shared environment for integration tests.
///
/// Call [setup] from each test file's [setUpAll] and [release] from each
/// [tearDownAll]. The bootstrap runs only once; teardown only fires after the
/// last file has released.
///
/// Bootstrap flow
/// --------------
/// 1. Login with bootstrap-admin credentials via **cookie auth** → session
///    cookie captured automatically.
/// 2. Create an ephemeral admin user (test admin) using the cookie client.
/// 3. Login as the test admin → generate a session **token**.
/// 4. Build [client] (token auth) — used by every test file.
///
/// Teardown flow
/// -------------
/// Delete the test admin (via bootstrap client) → close all clients.
///
/// Environment variables
/// ---------------------
/// ```
/// TRACCAR_BASE_URL   (default: http://localhost:8082/api)
/// TRACCAR_EMAIL      (default: admin@example.com)
/// TRACCAR_PASSWORD   (default: admin)
/// ```
class TestConfig {
  // ── Bootstrap credentials (env / defaults) ─────────────────────────────────

  static final String baseUrl =
      Platform.environment['TRACCAR_BASE_URL'] ?? 'http://localhost:8082/api';

  static final String _bootstrapEmail =
      Platform.environment['TRACCAR_EMAIL'] ?? 'admin@example.com';

  static final String _bootstrapPassword =
      Platform.environment['TRACCAR_PASSWORD'] ?? 'admin';

  // ── Test-admin credentials (set during [setup]) ────────────────────────────

  /// Email of the ephemeral admin user created during [setup].
  static late String testAdminEmail;

  /// Password of the ephemeral admin user created during [setup].
  static late String testAdminPassword;

  /// Database id of the ephemeral admin user.
  static late int testAdminId;

  /// Session token generated for the ephemeral admin user.
  static late String testToken;

  // ── Shared clients ─────────────────────────────────────────────────────────

  /// Cookie-authenticated client for the bootstrap admin.
  /// Available after [setup]; used internally for teardown.
  static late TraccarClient bootstrapClient;

  /// Token-authenticated client for the ephemeral test admin.
  /// Use this in all test files.
  static late TraccarClient client;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  static bool _initialized = false;
  static int _refCount = 0;

  /// Whether a live server is configured.
  static bool get isConfigured =>
      Platform.environment.containsKey('TRACCAR_BASE_URL') ||
      Platform.environment.containsKey('TRACCAR_EMAIL');

  /// Skip message for test groups that require a live server.
  static String? get skipReason => isConfigured
      ? null
      : 'Set TRACCAR_BASE_URL / TRACCAR_EMAIL / TRACCAR_PASSWORD to run.';

  /// Initialises the shared test environment (idempotent).
  ///
  /// Steps:
  /// 1. Login with bootstrap-admin credentials (cookie auth).
  /// 2. Create an ephemeral admin user.
  /// 3. Login as that user → generate a session token.
  /// 4. Build [client] (token auth).
  ///
  /// Returns [client].
  static Future<TraccarClient> setup() async {
    _refCount++;
    if (_initialized) return client;

    final ts = DateTime.now().millisecondsSinceEpoch;
    testAdminEmail = 'testadmin_$ts@traccar.test';
    testAdminPassword = 'TestPass$ts!';

    // Step 1 – login as bootstrap admin with cookie auth.
    bootstrapClient =
        TraccarClient.cookie(baseUrl, _bootstrapEmail, _bootstrapPassword);
    await bootstrapClient.session
        .login(email: _bootstrapEmail, password: _bootstrapPassword);

    // Step 2 – create the ephemeral test-admin user.
    final newAdmin = await bootstrapClient.users.createUser(
      User(
        name: 'Test Admin $ts',
        email: testAdminEmail,
        password: testAdminPassword,
        administrator: true,
      ),
    );
    testAdminId = newAdmin.id!;

    // Step 3 – login as test-admin and generate a session token.
    final tempClient =
        TraccarClient.basic(baseUrl, testAdminEmail, testAdminPassword);
    await tempClient.session
        .login(email: testAdminEmail, password: testAdminPassword);
    testToken = await tempClient.session.generateToken(
      expiration: DateTime.now().add(const Duration(hours: 2)),
    );
    tempClient.close();

    // Step 4 – build the shared token client for all test files.
    client = TraccarClient.token(baseUrl, testToken,
        logLevel: TraccarLogLevel.info);

    _initialized = true;
    return client;
  }

  /// Decrements the reference count.
  ///
  /// When the last test file releases, deletes the test-admin user and closes
  /// all clients.
  static Future<void> release() async {
    if (_refCount > 0) _refCount--;
    if (_refCount > 0 || !_initialized) return;
    await _cleanup();
  }

  static Future<void> _cleanup() async {
    try {
      await bootstrapClient.users.deleteUser(testAdminId);
    } catch (_) {}
    client.close();
    bootstrapClient.close();
    _initialized = false;
  }
}
