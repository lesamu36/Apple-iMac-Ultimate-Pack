#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$BASE_DIR/lib/colors.sh"
source "$BASE_DIR/lib/logger.sh"

echo -e "${BLUE}"
echo "XFCE Optimization"
echo "================================="
echo -e "${NC}"


echo -e "${GREEN}✓ Optimizing XFCE desktop${NC}"


# Disable compositor for old GPU
xfconf-query -c xfwm4 -p /general/use_compositing -s false 2>/dev/null


# Reduce animations
xfconf-query -c xfwm4 -p /general/mousewheel_rollup -s false 2>/dev/null


# Enable thumbnail cache cleanup
rm -rf ~/.cache/thumbnails/*


log "XFCE optimization completed"

echo "XFCE optimization completed."
