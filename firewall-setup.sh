#!/bin/bash
# firewall-setup.sh - Configure firewall (WSL-safe)

# Check if running in WSL
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
    echo "WSL detected: Using ufw (Windows Firewall handles actual filtering)"

    # WSL:ufw 
    sudo ufw --force reset
    sudo ufw allow 22/tcp
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw --force enable

    echo "=== UFW Rules Applied (Windows Firewall under the hood) ==="
    sudo ufw status verbose

else
    echo "Native Linux detected: Using iptables"

    # iptables for Linux servers
    sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
    sudo iptables -A INPUT -j DROP
    sudo iptables -P OUTPUT ACCEPT

    echo "=== iptables Rules Applied ==="
    sudo iptables -L -v --line-numbers
fi
