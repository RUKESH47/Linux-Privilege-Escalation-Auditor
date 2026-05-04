#!/bin/bash

# Report files
HIGH="reports/high.txt"
MEDIUM="reports/medium.txt"
LOW="reports/low.txt"

# Create reports folder if not exists
mkdir -p reports

# Clear old reports
> $HIGH
> $MEDIUM
> $LOW

echo "=========================================="
echo " Linux Privilege Escalation Auditor"
echo "=========================================="

# Run modules
bash modules/suid_check.sh $HIGH $MEDIUM $LOW
bash modules/sudo_check.sh $HIGH $MEDIUM $LOW
bash modules/writable_check.sh $HIGH $MEDIUM $LOW
bash modules/cron_check.sh $HIGH $MEDIUM $LOW

# Final prioritized output
echo ""
echo "=========== PRIORITIZED REPORT ============"

echo ""
echo "[ HIGH RISK ]"
cat $HIGH

echo "[ MEDIUM RISK ]"
cat $MEDIUM

echo "[ LOW RISK ]"
cat $LOW

# Risk Score
HIGH_COUNT=$(grep -c "\[HIGH\]" $HIGH)
MEDIUM_COUNT=$(grep -c "\[MEDIUM\]" $MEDIUM)
LOW_COUNT=$(grep -c "\[LOW\]" $LOW)

SCORE=$((HIGH_COUNT*10 + MEDIUM_COUNT*5 + LOW_COUNT*2))

echo ""
echo "=========================================="
echo " Total Risk Score: $SCORE"
echo "=========================================="
