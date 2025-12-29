# linux-admin-scripts
## Author

Im a 1st software development student in MTU CORK , this is docummentation/ proof of my learning of linux and DevOps .Thanks

Overview: System admin scripts for DecOps tasks

## scripts
monitors root partition disk usage and alerts when above 80%

**Usage** "./disk-monitor.sh"

**Output** 
- "disk is vulnerable" (if > 80%)
- "disk has suffecient space at %X" (if<80%)

-User life cycle

**Usage** "sudo bash ./user-mgmt.sh"
**Output** 
User created
Set password for tempdev
tempdev : tempdev sudo
userdel: tempdev mail spool (/var/mail/tempdev) not found

-firewall-setup.sh
Configures firewall with SSH access while denying all other inbound traffic.

**Usage:**

sudo bash ./firewall-setup.sh


-backup automation

**Usage** ./backup-automation.sh
**output** 54M Dec 28 20:40 /tmp/backups/backup-XXXXXX
I also used crontab to make this happen at 2am everyday



-system health script

a script that checks, load time, memory used and disk usage

**usage** ./system-health.sh
**output** DISK: OK MEM: OK LOAD: OK
