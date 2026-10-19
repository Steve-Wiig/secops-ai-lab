# Dashboard Memory Context

## Fix Patterns (Past Issues & Solutions)

### ✅ VERIFIED
- **Symptom:** Logs tab displaying website HTML instead of log entries
- **Root Cause:** /api/logs endpoint was missing or returning non-JSON due to server.py route misconfiguration after Aider corruption event
- **Solution:** Restored index.html from commit 38c97477, ran Aider with forensic brief to rebuild clean JS + verify all 5 API endpoints exist with correct Content-Type headers. Created verify_dashboard.py for automated validation.

## Recent Test Results
- ✅ PASS `api_settings_get` @ 82411961: Content-Type=application/json
- ✅ PASS `api_live_activity_json` @ 82411961: Content-Type=application/json
- ✅ PASS `api_system_status` @ 82411961: All keys present
- ✅ PASS `api_logs_json` @ 82411961: Content-Type=application/json, Keys=['logs']
- ✅ PASS `root_html_served` @ 82411961: Status=200, Banner=Yes
