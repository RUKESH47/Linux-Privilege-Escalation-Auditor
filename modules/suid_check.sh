#!/bin/bash

HIGH=$1
MEDIUM=$2
LOW=$3

echo "[*] Checking SUID binaries..."

find / -perm -4000 -type f 2>/dev/null | while read file; do
    case "$file" in
        /bin/su|/usr/bin/passwd) continue ;;
        *)
            echo "[MEDIUM] Unusual SUID binary: $file" >> $MEDIUM
            echo "Fix: Remove SUID using chmod -s $file" >> $MEDIUM
            echo "" >> $MEDIUM
        ;;
    esac
done
