#!/bin/bash
usage_percentage=$(df --output=pcent / | tail -n 1 | tr -d ' %')
if [[ $usage_percentage -gt 80 ]]; then
	echo "Disk is Vulnerable"
else
	echo "Disk has sufficient space at $usage_percentage%"
fi
