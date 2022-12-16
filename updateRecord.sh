#!/bin/bash
. ./commonFunctions.sh
while true
do
    while true
    do
    echo ""
    echo `ls -d ./$currentDatabase/*`
    echo ""
    read -p "which table do you want to update a record in: " table
    echo ""
    if [[ -f ./$currentDatabase/$table/$table ]]; then
        break
    else
        echo "there is no table with such a name"
    fi
    done

    cat ./$currentDatabase/$table/$table
   
    columnSelected=`awk 'BEGIN{FS=":"}{
        if($3=="Y")
        {
            print $1
        }
    }' ./$currentDatabase/$table/"$table.metadata"`

    echo "you can update with $columnSelected only because it's the primary key"
    read -p "select which Record you want to update by its $columnSelected: " RecordSelceted

    break 
done