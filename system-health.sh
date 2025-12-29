#!/bin/bash
# system-health.sh - Check disk, memory, and load

# === DISK CHECK ===
DISK_STATUS="OK"
DISK_OUTPUT=$(df -H --output=source,pcent | grep -v "snapfuse" | grep -v "Use%")

while IFS= read -r line; do
    filesystem=$(echo $line | awk '{print $1}')
    usage=$(echo $line | awk '{print $2}' | tr -d '%')
    
    if [ "$usage" -gt 90 ]; then
        echo "CRITICAL: $filesystem at ${usage}%"
        DISK_STATUS="CRITICAL"
    elif [ "$usage" -gt 80 ]; then
        echo "WARNING: $filesystem at ${usage}%"
        DISK_STATUS="WARNING"
    fi
done <<< "$DISK_OUTPUT"

# === LOAD CHECK ===
CORES=$(nproc)
LOAD_1MIN=$(cat /proc/loadavg | awk '{print $1}')
LOAD_STATUS="OK"

if (( $(echo "$LOAD_1MIN < $CORES" | bc -l) )); then
    LOAD_STATUS="OK"
elif (( $(echo "$LOAD_1MIN < $CORES * 2" | bc -l) )); then
    LOAD_STATUS="WARNING"
    echo "WARNING: Load at ${LOAD_1MIN} (cores: ${CORES})"
else
    LOAD_STATUS="CRITICAL"
    echo "CRITICAL: Load at ${LOAD_1MIN} (cores: ${CORES})"
fi

# === MEMORY CHECK ===
memoryusage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
MEM_STATUS="OK"
mem_int=${memoryusage%.*}

if [ "$mem_int" -gt 90 ]; then
    echo "CRITICAL: Memory at ${memoryusage}%"
    MEM_STATUS="CRITICAL"
elif [ "$mem_int" -gt 80 ]; then
    echo "WARNING: Memory at ${memoryusage}%"
    MEM_STATUS="WARNING"
else
    MEM_STATUS="OK"
fi

# === FINAL SUMMARY ===
echo "DISK: $DISK_STATUS MEM: $MEM_STATUS LOAD: $LOAD_STATUS"
