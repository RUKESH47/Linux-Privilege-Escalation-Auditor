#!/bin/bash

HIGH=$1
MEDIUM=$2
LOW=$3

echo "[*] Checking writable sensitive files..."

# Critical file
if [ -w /etc/passwd ]; then
    echo "[HIGH] Writable /etc/passwd detected" >> $HIGH
    echo "Fix: chmod 644 /etc/passwd" >> $HIGH
    echo "" >> $HIGH
fi

# General writable files
find /etc -writable -type f 2>/dev/null | while read file; do
    echo "[MEDIUM] Writable file: $file" >> $MEDIUM
    echo "Fix: chmod 644 $file" >> $MEDIUM
    echo "" >> $MEDIUM
done
