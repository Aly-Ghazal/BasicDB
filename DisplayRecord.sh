#!/bin/bash

while true
do
    echo ""
    echo `ls -d ./$currentDatabase/*`
    echo ""
    read -p "which table do you want to display a record from: " table
    echo ""
    if [[ -f ./$currentDatabase/$table/$table ]]; then
        break
    else
        echo "there is no table with such a name"
    fi
done

columns=`awk 'BEGIN{FS=":"}{print $1}' ./$currentDatabase/$table/"$table.metadata"`
echo ""
echo "$columns"

while true
do
    read -p "which column do you want to select from to display records: " columnSelected
    if [[ $columns == *$columnSelected* ]]; then
        break
    else
        echo "This column doesn't exist in this table"
    fi
done

  columnNumber=`awk -v columnToBeSearched="$columnSelected" 'BEGIN{FS=":"}{
        if($1==columnToBeSearched)
        {
            print NR
        }
    }' ./$currentDatabase/$table/"$table.metadata"`

read -p "select which Record(s) you want to display by its $columnSelected: " RecordSelceted
Result=`awk -v WantedRecords="$RecordSelceted" -v ColumnN="$columnNumber" 'BEGIN{FS=":"}
             {
                if($ColumnN==WantedRecords){
                print $0
                }
             }' ./$currentDatabase/$table/"$table"`
             
echo "$Result"
