#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$BASE_DIR/lib/colors.sh"
source "$BASE_DIR/lib/logger.sh"
source "$BASE_DIR/lib/utils.sh"

echo -e "${BLUE}"
echo "========================================="
echo " iMac Performance Optimization"
echo "========================================="
echo -e "${RESET}"

log "Starting performance optimization"


echo -e "${GREEN}✓ Applying RAM optimization${RESET}"

# Enable zram if available
if command_exists systemctl; then
    systemctl enable --now zramswap.service 2>/dev/null
fi


echo -e "${GREEN}✓ Optimizing HDD read ahead${RESET}"

# HDD tuning
DISK=$(lsblk -ndo NAME,TYPE | awk '$2=="disk"{print $1}' | head -1)

if [ -n "$DISK" ]; then
    blockdev --setra 4096 /dev/$DISK 2>/dev/null
fi


echo -e "${GREEN}✓ Reducing swappiness${RESET}"

sysctl -w vm.swappiness=10 >/dev/null


echo -e "${GREEN}✓ Cleaning temporary files${RESET}"

apt autoremove -y >/dev/null 2>&1
apt autoclean >/dev/null 2>&1


log "Performance optimization completed"


echo ""
echo -e "${BLUE}"
echo "Performance optimization completed."
echo -e "${RESET}"
