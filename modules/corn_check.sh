#!/bin/bash

HIGH=$1
MEDIUM=$2
LOW=$3

echo "[*] Checking cron jobs..."

# Check cron directories
for dir in /etc/cron.daily /etc/cron.hourly /etc/cron.weekly; do
    if [ -d "$dir" ]; then
        find $dir -type f -writable 2>/dev/null | while read file; do
            echo "[HIGH] Writable cron job: $file" >> $HIGH
            echo "Fix: chmod 700 $file" >> $HIGH
            echo "" >> $HIGH
        done
    fi
done
