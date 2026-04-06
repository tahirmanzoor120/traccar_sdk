#!/usr/bin/env bash
# test_local.sh — run integration tests against a local Traccar instance.
#
# Usage:
#   ./test_local.sh [--no-docker]
#
#   --no-docker   Skip docker compose up/down; assume Traccar is already running.
#
# Integration test bootstrap (handled by TestConfig.setup() inside Dart tests)
# ---------------------------------------------------------------------------
# 1. Login with the given bootstrap-admin credentials → session cookie saved.
# 2. Create an ephemeral admin user (test admin) with the cookie auth.
# 3. Login as test admin → generate a session token.
# 4. Run all API tests authenticated as the test admin (token auth).
# 5. Delete all created resources, then delete the test admin.
#
# Environment variables:
#   TRACCAR_BASE_URL   (default: http://localhost:8082/api)
#   TRACCAR_EMAIL      (default: admin@example.com)
#   TRACCAR_PASSWORD   (default: admin)

set -euo pipefail

# ── config ─────────────────────────────────────────────────────────────────────
TRACCAR_BASE_URL="${TRACCAR_BASE_URL:-http://localhost:8082/api}"
TRACCAR_EMAIL="${TRACCAR_EMAIL:-admin@example.com}"
TRACCAR_PASSWORD="${TRACCAR_PASSWORD:-admin}"
MANAGE_DOCKER=true

for arg in "$@"; do
  [[ "$arg" == "--no-docker" ]] && MANAGE_DOCKER=false
done

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# ── helpers ────────────────────────────────────────────────────────────────────
log()  { echo "▶ $*"; }
ok()   { echo "✓ $*"; }
fail() { echo "✗ $*" >&2; exit 1; }

wait_for_traccar() {
  local url="$1"
  local max=60   # seconds
  local elapsed=0
  log "Waiting for Traccar to be ready at $url ..."
  until curl -sf "$url" -o /dev/null 2>/dev/null; do
    if (( elapsed >= max )); then
      fail "Traccar did not become ready within ${max}s."
    fi
    sleep 2
    (( elapsed += 2 ))
  done
  ok "Traccar is up (${elapsed}s)."
}

# ── docker ─────────────────────────────────────────────────────────────────────
DOCKER_STARTED=false
if $MANAGE_DOCKER; then
  if ! command -v docker &>/dev/null; then
    fail "docker not found. Install Docker or pass --no-docker."
  fi

  log "Starting Traccar via docker compose..."
  docker compose up -d

  # Respect the container's healthcheck; also poll externally so we know when
  # the API is reachable (the health endpoint doesn't require auth).
  wait_for_traccar "http://localhost:8082/api/server"
  DOCKER_STARTED=true
else
  wait_for_traccar "http://localhost:8082/api/server"
fi

# ── flutter pub get (idempotent) ───────────────────────────────────────────────
log "Running flutter pub get..."
flutter pub get

# ── validate bootstrap credentials ────────────────────────────────────────────
# Do a real login via curl to confirm credentials before spending time on tests.
log "Validating bootstrap credentials (${TRACCAR_EMAIL})..."
COOKIE_JAR="$(mktemp)"
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
  -X POST "${TRACCAR_BASE_URL}/session" \
  -c "$COOKIE_JAR" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "email=${TRACCAR_EMAIL}" \
  --data-urlencode "password=${TRACCAR_PASSWORD}")
rm -f "$COOKIE_JAR"
if [[ "$HTTP_STATUS" != "200" ]]; then
  fail "Bootstrap login returned HTTP $HTTP_STATUS. Check TRACCAR_EMAIL / TRACCAR_PASSWORD."
fi
ok "Bootstrap login succeeded (HTTP 200) — cookie-auth confirmed."

# ── unit tests (offline, always run) ──────────────────────────────────────────
log "Running unit tests..."
flutter test test/unit/ --reporter=compact
ok "Unit tests passed."

# ── integration tests ──────────────────────────────────────────────────────────
log "Running integration tests (${TRACCAR_BASE_URL}, ${TRACCAR_EMAIL})..."

TRACCAR_BASE_URL="$TRACCAR_BASE_URL" \
TRACCAR_EMAIL="$TRACCAR_EMAIL"       \
TRACCAR_PASSWORD="$TRACCAR_PASSWORD" \
flutter test test/integration/ --reporter=compact

ok "Integration tests passed."

# ── teardown ───────────────────────────────────────────────────────────────────
if $DOCKER_STARTED; then
  log "Stopping Traccar container..."
  docker compose down
  ok "Container stopped."
fi

echo ""
echo "All tests passed."
