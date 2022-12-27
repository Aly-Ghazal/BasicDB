#!/bin/bash
while true
do
    echo ""
    echo "here is your Available Tables..."
    echo ""
    echo `ls -d ./$currentDatabase/*|rev|cut -d "/" -f 1|rev`
    echo ""
    read -p "which table do you want to display: " table
    if [[ -f ./$currentDatabase/$table/$table ]]; then
        echo ""
        cat ./$currentDatabase/$table/$table
        echo ""
        break
    else
        echo "please choose an avilable table in this Database"
    fi
done