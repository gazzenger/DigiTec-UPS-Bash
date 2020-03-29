#!/bin/bash

cd somelocation

TIMEOUT=20

sudo ./nutdrv_qx -a myups -DDDDD 2>&1 >/dev/null | while read line ; do
    if echo "$line" | grep "SETINFO input.voltage \"0.0\""
    then
        if [ ! "$START" ]; then
           START=$(echo "$line" | awk '{print $1;}')
        fi
        echo "matched"
    elif echo "$line" | grep "SETINFO input.voltage \""
    then
        unset START
    else
        if [ "$START" ]; then
            CUR=$(echo "$line" | awk '{print $1;}')
            if (( $(echo "($CUR - $START) > $TIMEOUT" |bc -l) )); then
                echo "Time to Shutdown"
                ssh -t server1 sudo poweroff
                ssh -t server2 sudo poweroff
            fi
        fi
    fi
done

