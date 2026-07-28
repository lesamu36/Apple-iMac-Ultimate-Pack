#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$BASE_DIR/lib/colors.sh"
source "$BASE_DIR/lib/logger.sh"

CONFIG="$BASE_DIR/config.conf"

echo ""
echo -e "${BLUE}"
echo "========================================="
echo " Installation Questions"
echo "========================================="
echo -e "${RESET}"

echo ""

read -rp "Do you use Bluetooth? (y/n): " USE_BLUETOOTH
read -rp "Do you use a Printer? (y/n): " USE_PRINTER
read -rp "Do you use OpenVPN? (y/n): " USE_OPENVPN
read -rp "Optimize Firefox? (y/n): " OPT_FIREFOX
read -rp "Apply macOS Theme? (y/n): " MACOS_THEME

cat > "$CONFIG" <<EOF
USE_BLUETOOTH=$USE_BLUETOOTH
USE_PRINTER=$USE_PRINTER
USE_OPENVPN=$USE_OPENVPN
OPT_FIREFOX=$OPT_FIREFOX
MACOS_THEME=$MACOS_THEME
EOF

log "Configuration file created"

echo ""
echo -e "${GREEN}Configuration saved successfully.${RESET}"
