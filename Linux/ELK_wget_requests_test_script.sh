#!/bin/bash
while :
do
        for i in 5 6 7
        do
                wget -q -O /dev/null 10.0.0.$i
        done
done
