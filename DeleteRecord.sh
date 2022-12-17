#!/bin/bash

while true
do
    echo ""
    echo `ls -d ./$currentDatabase/*`
    echo ""
    read -p "which table do you want to delete a record from: " table
    echo ""
    if [[ -f ./$currentDatabase/$table/$table ]]; then
        break
    else
        echo "there is no table with such a name"
    fi
done
    
    columnSelected=`awk 'BEGIN{FS=":"}{
        if($3=="Y")
        {
            print $1
        }
    }' ./$currentDatabase/$table/"$table.metadata"`

echo "you can delete with $columnSelected only because it's the primary key"
cat ./$currentDatabase/$table/$table
read -p "select which Record you want to update by its $columnSelected: " RecordSelceted
sed -i "/^$RecordSelceted:/d" "./$currentDatabase/$table/$table"
#sed -i "/:$RecordSelceted$/d" "./$currentDatabase/$table/$table"
cat ./$currentDatabase/$table/$table
   
