#!/bin/bash

CONFIG_FILE="$BASE_DIR/config.conf"

# Ensure configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found!"
    echo "Please run 04-questions.sh first."
    exit 1
fi

# Load configuration
source "$CONFIG_FILE"
