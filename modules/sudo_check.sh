#!/bin/bash

HIGH=$1
MEDIUM=$2
LOW=$3

echo "[*] Checking sudo configuration..."

sudo -l 2>/dev/null | grep -i "nopasswd" > /dev/null

if [ $? -eq 0 ]; then
    echo "[HIGH] NOPASSWD sudo privilege detected" >> $HIGH
    echo "Fix: Edit /etc/sudoers and remove NOPASSWD entries" >> $HIGH
    echo "" >> $HIGH
else
    echo "[LOW] No risky sudo misconfiguration found" >> $LOW
    echo "" >> $LOW
fi
