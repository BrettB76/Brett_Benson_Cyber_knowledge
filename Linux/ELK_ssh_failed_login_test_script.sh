#!/bin/bash
while :
do
        for i in 5 6 7
        do
                ssh admin@10.0.0.$i
        done
done
