#!/bin/bash



# Create user 'tempdev'
if id "tempdev" &>/dev/null; then
    echo "User already exists, aborting"
    exit 1
else
    useradd -m tempdev
    echo "User created"
fi
# Set password for 'tempdev'
echo 'tempdev:TempPass123' | chpasswd
echo "Set password for tempdev"


# Add 'tempdev' to sudo group
sudo usermod -aG sudo tempdev

groups tempdev

# Delete 'tempdev' user
PROCESS_COUNT=$(ps -u tempdev | tail -n +2 | wc -l)

if [ $PROCESS_COUNT -ne 0 ]; then
    echo "User has running processes:"
    ps -u tempdev
    echo "Aborting deletion"
    exit 1
fi

sudo userdel -r tempdev
