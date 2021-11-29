#!/bin/bash
echo Time: $1 $2 Date: $3 Casino Game: $4
cat $3_Dealer_schedule | grep $1 | grep $2 | awk -F" " '{print "BlackJack: " $3,$4}' > dealertime
cat $3_Dealer_schedule | grep $1 | grep $2 | awk -F" " '{print "Roulette: " $5,$6}' >> dealertime
cat $3_Dealer_schedule | grep $1 | grep $2 | awk -F" " '{print "Texas_Hold_EM: " $7,$8}' >> dealertime
grep -w $4 dealertime | awk -F: '{print "Dealer: " $2}'
rm dealertime
