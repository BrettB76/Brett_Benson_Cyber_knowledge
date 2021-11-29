#!/bin/bash
#test sctipt from week 6 session 1
mkdir ~/research 2>/dev/null

echo "Here is our script: $(date +%d-%m-%y)" > ~/research/sys_info.txt
echo -e "\nMachine type info: $MACHTYPE" >> ~/research/sys_info.txt
echo -e "\nuname info: $(uname -a)" >> ~/research/sys_info.txt
echo -e "\nIP Address is: $(hostname -I)" >> ~/research/sys_info.txt
echo -e "\nThe hostname is: $HOSTNAME" >> ~/research/sys_info.txt
echo -e "\nDNS servers: $(cat /etc/resolv.conf)" >> ~/research/sys_info.txt
echo -e "\nMemory information: $(free)" >> ~/research/sys_info.txt
echo -e "\nCPU info: $(lscpu | grep CPU)" >> ~/research/sys_info.txt
echo -e "\nDisk usage: $(df -H | head -2)" >> ~/research/sys_info.txt
echo -e "\nWho is logged in: \n $(who -a)" >> ~/research/sys_info.txt
echo -e "\n777 executable files: \n $(find /home -type f -perm 777)" >> ~/research/sys_info.txt
echo -e "\nTop 10 Processes: \n $(ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head)" >> ~/research/sys_info.txt
