#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"

ok() {
    echo -e "${GREEN}✓ $1${RESET}"
}

warn() {
    echo -e "${YELLOW}! $1${RESET}"
}

err() {
    echo -e "${RED}✗ $1${RESET}"
}

info() {
    echo -e "${BLUE}$1${RESET}"
}
