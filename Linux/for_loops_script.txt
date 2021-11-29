#!/bin/bash

#setting variables
states=('qld' 'nsw' 'vic' 'tas' 'sa')

        #then the loop
for state in ${states[@]};
do
        if [ $state = 'nsw' ]
        then
        echo "$state is the best"
        else
        echo "$state is not the best"
        fi
done

# to select only numbers 3 or 5 or 7
for num in {0..9}
do
        if [ $num = 3 ] || [ $num = 5 ] || [ $num = 7 ]
        then 
                echo $num
        fi
done

# to show file listing as -lah (first, run the command ls to get a list. Then, for each item in that list)
# ls -lah $file run this command on the current item. $file represents a different item from the list of files returned by the expansion $(ls)
for file in $(ls);
do
    ls -lah $file
done

### etc paths to display permissions
etc=('/etc/shadow' '/etc/passwd')
for etc in ${etc[@]};
do
        ls -l $etc
done
