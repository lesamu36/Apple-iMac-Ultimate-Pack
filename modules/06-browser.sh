#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$BASE_DIR/lib/colors.sh"
source "$BASE_DIR/lib/logger.sh"
source "$BASE_DIR/lib/config.sh"

echo ""
echo "========================================="
echo " Firefox Optimization"
echo "========================================="
echo ""

# Skip if user doesn't want Firefox optimization
if [ "$OPT_FIREFOX" != "y" ]; then
    echo "Firefox optimization skipped."
    log "Firefox optimization skipped."
    exit 0
fi

echo "Optimizing Firefox..."

REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME=$(eval echo "~$REAL_USER")

FIREFOX_PROFILE=$(find "$REAL_HOME/.mozilla/firefox" -maxdepth 1 -type d -name "*.default*" | head -n 1)

if [ -z "$FIREFOX_PROFILE" ]; then
    echo "Firefox profile not found."
    log "Firefox profile not found."
    exit 0
fi

echo "Firefox profile found:"
echo "$FIREFOX_PROFILE"

USER_JS="$FIREFOX_PROFILE/user.js"

if [ -f "$USER_JS" ]; then
    cp "$USER_JS" "$USER_JS.bak"
    echo "Existing user.js backed up."
    log "Firefox user.js backed up."
fi

cat > "$USER_JS" <<EOF
// ======================================
// Apple iMac Ultimate Pack v2
// Firefox Optimizations
// Generated automatically
// ======================================

// Performance
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.enable", true);
user_pref("browser.sessionstore.interval", 60000);
user_pref("browser.tabs.unloadOnLowMemory", true);

// Usability
user_pref("browser.tabs.closeWindowWithLastTab", false);

// Smooth browsing
user_pref("image.mem.decode_bytes_at_a_time", 32768);
user_pref("network.prefetch-next", false);
EOF

echo ""
echo "Firefox optimization applied successfully."
echo "Configuration:"
echo "$USER_JS"

log "Firefox optimization applied."
