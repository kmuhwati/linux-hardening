#!/bin/bash

# Comprehensive Linux System Hardening Script
# Author: Kumbirai Muhwati
# WARNING: This script is for educational purposes only.
# Always test thoroughly before using on production systems.

# Check if script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update the system
echo "Updating the system..."
apt update && apt upgrade -y

# Set strong password policy
echo "Setting strong password policy..."
sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t90/' /etc/login.defs
sed -i 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS\t10/' /etc/login.defs
sed -i 's/PASS_WARN_AGE\t7/PASS_WARN_AGE\t7/' /etc/login.defs

# Configure PAM to enforce password complexity
echo "Configuring PAM for password complexity..."
apt install libpam-pwquality -y
sed -i 's/# difok = 1/difok = 3/' /etc/security/pwquality.conf
sed -i 's/# minlen = 8/minlen = 14/' /etc/security/pwquality.conf
sed -i 's/# dcredit = 0/dcredit = -1/' /etc/security/pwquality.conf
sed -i 's/# ucredit = 0/ucredit = -1/' /etc/security/pwquality.conf
sed -i 's/# lcredit = 0/lcredit = -1/' /etc/security/pwquality.conf
sed -i 's/# ocredit = 0/ocredit = -1/' /etc/security/pwquality.conf

# Disable root login via SSH
echo "Disabling root login via SSH..."
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# Configure SSH
echo "Configuring SSH..."
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/X11Forwarding yes/X11Forwarding no/' /etc/ssh/sshd_config
echo "AllowUsers your_username" >> /etc/ssh/sshd_config
systemctl restart ssh

# Set up a basic firewall using UFW
echo "Setting up basic firewall..."
apt install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Install and configure fail2ban
echo "Installing and configuring fail2ban..."
apt install fail2ban -y
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sed -i 's/bantime  = 10m/bantime  = 1h/' /etc/fail2ban/jail.local
sed -i 's/findtime  = 10m/findtime  = 20m/' /etc/fail2ban/jail.local
sed -i 's/maxretry = 5/maxretry = 3/' /etc/fail2ban/jail.local
systemctl enable fail2ban
systemctl start fail2ban

# Disable unused services
echo "Disabling unused services..."
systemctl disable avahi-daemon
systemctl disable cups
systemctl disable rpcbind

# Remove unnecessary packages
echo "Removing unnecessary packages..."
apt remove telnet rsh-server -y

# Secure shared memory
echo "Securing shared memory..."
echo "tmpfs     /run/shm     tmpfs     defaults,noexec,nosuid     0     0" >> /etc/fstab

# Set permissions on sensitive files
echo "Setting permissions on sensitive files..."
chmod 640 /etc/shadow
chmod 644 /etc/passwd

# Enable process accounting
echo "Enabling process accounting..."
apt install acct -y
/etc/init.d/acct start

# Enable auditd
echo "Enabling auditd..."
apt install auditd -y
systemctl enable auditd
systemctl start auditd

# Configure system logging
echo "Configuring system logging..."
sed -i 's/^\*\.emerg.*/\*\.emerg :omusrmsg:\*/' /etc/rsyslog.conf
systemctl restart rsyslog

# Disable USB storage
echo "Disabling USB storage..."
echo "install usb-storage /bin/true" >> /etc/modprobe.d/disable-usb-storage.conf

# Set GRUB password
echo "Setting GRUB password..."
grub-mkpasswd-pbkdf2 | tee grub.pass
GRUB_PASSWORD=$(cat grub.pass | sed -n 's/.*grub.pbkdf2.sha512.10000.\(.*\)/\1/p')
sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT=.*/& password_pbkdf2 root ${GRUB_PASSWORD}/" /etc/default/grub
update-grub

echo "Comprehensive hardening complete. Please review changes and reboot the system for all changes to take effect."