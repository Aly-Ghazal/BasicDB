#!/bin/bash
while true
do
    echo ""
    echo `ls -d ./$currentDatabase/*`
    echo ""
    read -p "which table do you want to insert in: " table
    if [[ -d ./$currentDatabase/$table ]]; then
        columnName=`awk '
                BEGIN{FS=":"}
                {
                    print $1
                }
                ' $currentDatabase/$table/"$table.metadata"`
        columntype=`awk '
                BEGIN{FS=":"}
                {
                    print $2
                }
                ' $currentDatabase/$table/"$table.metadata"`
            isPK=`awk '
                BEGIN{FS=":"}
                {
                    print $3
                }
                ' $currentDatabase/$table/"$table.metadata"`
            for i in $columnName
            do
                read -p "insert $i: " columnInput
                #echo without new line
                echo -n "$columnInput:" >> $currentDatabase/$table/"$table"
            done
            #finalRes=`cat $currentDatabase/$table/"$table"`
            #echo "\n" >> $currentDatabase/$table/"$table"
            sed -i '$ s/.$//'  $currentDatabase/$table/"$table"
            printf "\n" >> $currentDatabase/$table/"$table"
            break
    else
        echo "there is no table with such a name "
    fi
done