#!/bin/bash
source ./commonFunctions.sh
while true
do
    echo ""
    echo `ls -d ./$currentDatabase/*`
    echo ""
    read -p "which table do you want to delete its data: " table
     if [[ -f ./$currentDatabase/$table/$table ]]; then
        "" > ./$currentDatabase/$table/$table
        break
    else
        echo "please choose an avilable table in this Database"
    fi
done