#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "========================================="
echo " Apple iMac Ultimate Pack"
echo " Uninstaller"
echo "========================================="
echo ""

echo "This will restore available backup files."

LATEST_BACKUP=$(ls -dt "$BASE_DIR"/backup/* 2>/dev/null | head -n1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "No backup found."
    exit 1
fi

echo ""
echo "Using backup:"
echo "$LATEST_BACKUP"
echo ""

if [ -f "$LATEST_BACKUP/sysctl.conf" ]; then
    sudo cp "$LATEST_BACKUP/sysctl.conf" /etc/sysctl.conf
    echo "✓ Restored sysctl.conf"
fi

if [ -f "$LATEST_BACKUP/fstab" ]; then
    sudo cp "$LATEST_BACKUP/fstab" /etc/fstab
    echo "✓ Restored fstab"
fi

if [ -f "$LATEST_BACKUP/grub" ]; then
    sudo cp "$LATEST_BACKUP/grub" /etc/default/grub
    sudo update-grub
    echo "✓ Restored GRUB"
fi

echo ""
echo "Uninstall completed."
echo "Please reboot your iMac."
