#!/bin/sh

BLD="\033[0;1m"
NC="\033[0;0;39m"

echo "Recording net usage..."
echo "Press any key to stop recording"
SECONDS=0
start_bytes=$(($(cat /sys/class/net/[ew]*/statistics/rx_bytes | paste -sd '+')))
read
end_bytes=$(($(cat /sys/class/net/[ew]*/statistics/rx_bytes | paste -sd '+')))
echo -e "Time elapsed (seconds): ${BLD}${SECONDS}${NC}"
echo -e "Network usage  (bytes): ${BLD}$(numfmt --to=iec $((end_bytes-start_bytes)))${NC}"
