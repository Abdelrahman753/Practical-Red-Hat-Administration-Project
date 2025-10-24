#!/bin/bash
# ===========================================
# Health Check Script with Email Notification
# ===========================================

export HOME=/home/devops  # Ensure s-nail finds .mailrc

HOSTS=("192.168.137.57" "192.168.137.45")
LOGFILE="/var/log/Health_Check.log"
STATEFILE="/tmp/health_status.txt"
ALERT_EMAIL="abdelrahman.m.27.22@gmail.com"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

touch "$STATEFILE"
echo "---- Health check at $DATE ----" >> "$LOGFILE"

get_prev_status() {
    grep -w "$1" "$STATEFILE" | awk '{print $2}'
}

update_status() {
    sed -i "/^$1 /d" "$STATEFILE"
    echo "$1 $2" >> "$STATEFILE"
}

for HOST in "${HOSTS[@]}"; do
    if ping -c 2 -W 2 "$HOST" > /dev/null 2>&1; then
        STATUS="UP"
    else
        STATUS="DOWN"
    fi

    PREV_STATUS=$(get_prev_status "$HOST")

    echo "Host: $HOST | Current: $STATUS | Previous: $PREV_STATUS" >> "$LOGFILE"

    if [[ "$STATUS" != "$PREV_STATUS" ]]; then
        echo "Status changed for $HOST (from $PREV_STATUS to $STATUS)" >> "$LOGFILE"

        if [[ "$STATUS" == "DOWN" ]]; then
            echo "Trying to send DOWN alert email..." >> "$LOGFILE"
            echo "ALERT: Host $HOST is DOWN as of $DATE (detected by $(hostname))" | \
            s-nail -v -s "🚨 ALERT: $HOST is DOWN" "$ALERT_EMAIL" >> "$LOGFILE" 2>&1
        elif [[ "$STATUS" == "UP" ]]; then
            echo "Trying to send RECOVERY email..." >> "$LOGFILE"
            echo "RECOVERY: Host $HOST is UP again as of $DATE (detected by $(hostname))" | \
            s-nail -v -s "✅ RECOVERY: $HOST is UP again" "$ALERT_EMAIL" >> "$LOGFILE" 2>&1
        fi
    fi

    update_status "$HOST" "$STATUS"
done

echo "" >> "$LOGFILE"

