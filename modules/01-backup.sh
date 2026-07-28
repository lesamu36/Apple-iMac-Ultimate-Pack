#!/bin/bash

# ==========================================
# Apple iMac Ultimate Pack v2
# Backup Module
# ==========================================

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

BACKUP_DIR="$(dirname "$0")/../backup/$(date +%Y%m%d-%H%M%S)"

mkdir -p "$BACKUP_DIR"

echo
echo "========================================="
echo " Creating backup..."
echo "========================================="

FILES=(
"/etc/sysctl.conf"
"/etc/default/grub"
"/etc/fstab"
)

for FILE in "${FILES[@]}"
do
    if [ -f "$FILE" ]; then
        cp -a "$FILE" "$BACKUP_DIR/"
        echo -e "${GREEN}✓$(basename "$FILE") backed up${RESET}"
    else
        echo -e "${YELLOW}!$(basename "$FILE") not found${RESET}"
    fi
done

echo
echo "Backup saved to:"
echo "$BACKUP_DIR"
