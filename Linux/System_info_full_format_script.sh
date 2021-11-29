#!/bin/bash

#check if running as sudo
if [ $UID = 0 ]
then
        echo "Do not run as sudo"
        exit
fi

#variables for script
sys=$HOME/research/sys_info.txt
ipa=$(ip addr | grep inet | tail -2 | head -1)
fex=$(find /home -type f -perm 777)

#list to use later
commands=('date' 'uname -a' 'hostname -s')

#check if research directory exists
if [ ! -d $HOME/research ]
then
         mkdir $HOME/research
fi

#check if file exists - then delete it
if [ -f $sys ]
then
        rm $sys
fi

#title and date for script
echo "Here is our script: $(date +%d-%m-%y)" > $sys

#machine type
echo -e "\nMachine type info: $MACHTYPE" >> $sys

#uname information
echo -e "\nuname info: $(uname -a)" >> $sys

#IP address
echo -e "\nIP Address is: $ipa" >> $sys

#the hostname
echo -e "\nThe hostname is: $HOSTNAME" >> $sys

#DNS server information
echo -e "\nDNS servers: \n$(cat /etc/resolv.conf)" >> $sys

#Free memory
echo -e "\nMemory information: \n$(free)" >> $sys

#CPU information
echo -e "\nCPU info: \n$(lscpu | grep CPU)" >> $sys

#Disk usage
echo -e "\nDisk usage: \n$(df -H | head -2)" >> $sys

#Details of who is logged in
echo -e "\nWho is logged in: \n$(who -a)" >> $sys

#All executable files
echo -e "\n777 executable files: \n$fex" >> $sys

#2nd option for executable files to generate as loop on seperate lines
for execs in ${fex[@]}
do
        echo $execs >> $SYS
done

#Top 10 processes
echo -e "\nTop 10 Processes: \n$(ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head)" >> $sys





