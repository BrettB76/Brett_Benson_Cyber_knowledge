#!/bin/bash
echo 0310 $1 $2 >> Dealers_working_during_losses
grep -i "$1" 0310_Dealer_schedule | grep $2 | awk -F" " '{print "Dealer during loss: " $5, $6}' >> Dealers_working_during_losses
