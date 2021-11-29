#!/bin/bash
# Quick setup script for new server.

# Make sure the script is run as root.
if [ ! $UID -ne 0 ]
        then
        echo "Please run this script with sudo."
        exit
fi

# Create a log file that our script will use to track its progress
log_file=/var/log/setup_script.log

# Log file header
echo "Log file for general server setup script." >> $log_file
echo "############################" >> $log_file
echo "Log generated on: $(date)" >> $log_file
echo "############################" >> $log_file
echo "" >> $log_file

# List of necessary packages
packages=('nano' 'wget' 'net-tools' 'python' 'tripwire' 'tree' 'curl')

# Ensure all packages are installed
for package in ${packages[@]}
do
  if [ ! $(which $package) ]
  then
    apt install -y $package
  fi
done

# Print it out and Log it
echo "$(date) Installed needed pacakges: ${packages[@]}" | tee -a $logfile


