#!/bin/bash

# ==========================================
# Apple iMac Ultimate Pack v2
# System Check Module
# ==========================================

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo
echo "========================================="
echo " Apple iMac Ultimate Pack v2"
echo " System Check"
echo "========================================="
echo

# Root check
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Please run as root (sudo).${RESET}"
    exit 1
fi

# OS
if grep -qi "Linux Mint" /etc/os-release; then
    echo -e "${GREEN}✓ Linux Mint detected${RESET}"
else
    echo -e "${YELLOW}! Non-Mint distribution detected${RESET}"
fi

# Desktop
DESKTOP=$(echo "$SUDO_USER" | xargs -I{} sudo -u {} bash -c 'echo $XDG_CURRENT_DESKTOP')

echo "Desktop : $DESKTOP"

# Kernel
echo "Kernel  : $(uname -r)"

# RAM
RAM=$(free -h | awk '/Mem:/ {print $2}')
echo "RAM     : $RAM"

# CPU
CPU=$(grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f2 | xargs)
echo "CPU     : $CPU"

# Disk
DISK=$(lsblk -d -o NAME,SIZE,ROTA | awk 'NR==2')
echo "Disk    : $DISK"

# Machine
MODEL=$(cat /sys/devices/virtual/dmi/id/product_name)
echo "Model   : $MODEL"

# Broadcom
if lspci | grep -qi Broadcom; then
    echo -e "${GREEN}✓ Broadcom Wi-Fi detected${RESET}"
fi

echo
echo -e "${GREEN}System check completed.${RESET}"
echo
echo "Additional checks"

# Internet
if getent hosts archive.ubuntu.com >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Internet / DNS available${RESET}"
else
    echo -e "${YELLOW}! Internet or DNS unavailable${RESET}"
fi

echo "-----------------"

# Free disk space
FREE=$(df -h / | awk 'NR==2 {print $4}')
echo "Free disk space : $FREE"

# Broadcom driver
if lsmod | grep -q "^wl"; then
    echo -e "${GREEN}✓ Broadcom wl driver loaded${RESET}"
else
    echo -e "${RED}✗ Broadcom wl driver NOT loaded${RESET}"
fi

# TLP
if systemctl is-enabled tlp >/dev/null 2>&1; then
    echo -e "${GREEN}✓ TLP enabled${RESET}"
else
    echo -e "${YELLOW}! TLP not enabled${RESET}"
fi

# ZRAM
if swapon --show | grep -q zram; then
    echo -e "${GREEN}✓ ZRAM active${RESET}"
else
    echo -e "${YELLOW}! ZRAM not active${RESET}"
fi
