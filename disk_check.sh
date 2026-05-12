#!/bin/bash

# Disk and system health check script
# Sends alert if disk usage goes above threshold

THRESHOLD=80
LOGFILE="/var/log/disk_check.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$DATE] Running system health check..." | tee -a $LOGFILE

# check disk usage on all mounted partitions
echo "" | tee -a $LOGFILE
echo "--- Disk Usage ---" | tee -a $LOGFILE
df -h | grep -vE '^Filesystem|tmpfs|cdrom' | while read line; do
    usage=$(echo $line | awk '{print $5}' | sed 's/%//')
    partition=$(echo $line | awk '{print $6}')
    
    if [ "$usage" -ge "$THRESHOLD" ]; then
        echo "[$DATE] WARNING: $partition is at ${usage}% — above threshold of ${THRESHOLD}%" | tee -a $LOGFILE
    else
        echo "[$DATE] OK: $partition is at ${usage}%" | tee -a $LOGFILE
    fi
done

# check memory usage
echo "" | tee -a $LOGFILE
echo "--- Memory Usage ---" | tee -a $LOGFILE
free -h | tee -a $LOGFILE

# check CPU load
echo "" | tee -a $LOGFILE
echo "--- CPU Load ---" | tee -a $LOGFILE
uptime | tee -a $LOGFILE

# check top 5 processes by memory
echo "" | tee -a $LOGFILE
echo "--- Top 5 Processes by Memory ---" | tee -a $LOGFILE
ps aux --sort=-%mem | head -6 | tee -a $LOGFILE

echo "" | tee -a $LOGFILE
echo "[$DATE] Health check complete." | tee -a $LOGFILE
echo "--------------------------------------" | tee -a $LOGFILE
