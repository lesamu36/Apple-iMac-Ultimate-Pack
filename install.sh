#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BASE_DIR/lib/colors.sh"
source "$BASE_DIR/lib/logger.sh"
source "$BASE_DIR/lib/utils.sh"
run_module() {

    local module="$1"
    local message="$2"

    echo ""
    echo -e "${GREEN}${message}${RESET}"

    bash "$BASE_DIR/modules/$module"

    echo -e "${GREEN}✓ Done${RESET}"
}
clear

echo -e "${BLUE}"
echo "========================================="
echo " Apple iMac Ultimate Pack v2"
echo " Performance Optimizer"
echo "========================================="
echo -e "${RESET}"

echo ""

if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root:${RESET}"
    echo "sudo ./install.sh"
    exit 1
fi


echo -e "${GREEN}[1/8] Creating backup...${RESET}"

run_module "01-backup.sh" "Creating backup..."


echo -e "${GREEN}[2/8] Running hardware check...${RESET}"

run_module "00-check.sh" "Running hardware check..."


echo -e "${GREEN}[3/8] Applying performance optimization...${RESET}"

run_module "02-performance.sh" "Applying performance optimization..."

echo -e "${GREEN}[4/8] Configuring XFCE...${RESET}"

run_module "03-xfce.sh" "Configuring XFCE..."

echo -e "${GREEN}[5/8] Collecting user preferences...${RESET}"

run_module "04-questions.sh" "Collecting user preferences..."

echo -e "${GREEN}[6/8] Optimizing services...${RESET}"

run_module "05-services.sh" "Optimizing services..."

echo -e "${GREEN}[7/8] Optimizing Firefox...${RESET}"

run_module "06-browser.sh" "Optimizing Firefox..."

echo -e "${GREEN}[8/8] Optimizing Desktop...${RESET}"

run_module "07-desktop.sh" "Optimizing Desktop..."

echo ""

echo -e "${BLUE}"
echo "========================================="
echo " Installation Completed"
echo " Please reboot your iMac"
echo "========================================="
echo -e "${RESET}"

log "Apple iMac Ultimate Pack installed"
