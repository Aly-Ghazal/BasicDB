#!/bin/bash
source ./commonFunctions.sh
while true
do
    echo ""
    echo "here is your Available Tables..."
    echo ""
    echo `ls -d ./$currentDatabase/*|rev|cut -d "/" -f 1|rev`
    echo ""
    read -p "which table do you want to delete its data: " table
     if [[ -f ./$currentDatabase/$table/$table ]]; then
        echo -n "" > ./$currentDatabase/$table/$table
        break
    else
        echo "please choose an avilable table in this Database"
    fi
done