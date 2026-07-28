#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$BASE_DIR/lib/colors.sh"
source "$BASE_DIR/lib/logger.sh"
source "$BASE_DIR/lib/config.sh"

echo ""
echo "========================================="
echo " Desktop Optimization"
echo "========================================="
echo ""

echo "Applying desktop settings..."

# Theme
xfconf-query -c xsettings -p /Net/ThemeName -s "Mint-L" 2>/dev/null

# Icons
xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus" 2>/dev/null

# Cursor
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "Bibata-Modern-Classic" 2>/dev/null

# Font
xfconf-query -c xsettings -p /Gtk/FontName -s "Sans 10" 2>/dev/null

# Disable window compositing (improves speed on old hardware)
xfconf-query -c xfwm4 -p /general/use_compositing -n -t bool -s true 2>/dev/null || \
xfconf-query -c xfwm4 -p /general/use_compositing -s true

xfwm4 --replace >/dev/null 2>&1 &
sleep 2

echo ""
echo "Desktop optimization completed."

log "Desktop optimization completed."
