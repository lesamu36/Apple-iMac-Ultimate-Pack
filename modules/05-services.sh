#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$BASE_DIR/lib/colors.sh"
source "$BASE_DIR/lib/logger.sh"
source "$BASE_DIR/lib/config.sh"

echo ""
echo "========================================="
echo " Services Optimization"
echo "========================================="
echo ""

disable_service() {

    local service="$1"

    if systemctl list-unit-files | grep -q "^${service}"; then
        sudo systemctl disable --now "$service"
        log "Disabled $service"
        echo "✓ Disabled $service"
    else
        echo "- $service not installed"
    fi
}

echo ""

if [ "$USE_PRINTER" = "n" ]; then
    echo "Printer not used."

    disable_service "cups.service"
    disable_service "cups-browsed.service"
fi

echo ""

if [ "$USE_BLUETOOTH" = "n" ]; then
    echo "Bluetooth not used."

    disable_service "bluetooth.service"
else
    echo "Bluetooth will remain enabled."
fi
