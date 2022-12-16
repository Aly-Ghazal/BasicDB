#!/bin/bash
source ./commonFunctions.sh
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
            counter=0
            # <<< to redirect a string
            # $"\n" for newline not only "\n"
            #IFS dilimeter of read "white spaces"
            #read -d changes the character that stops the read from the default newline to the first character of the following argument.
            #'' with no spaces is called nul == \0
            #[referance](https://stackoverflow.com/questions/57497365/what-does-the-bash-read-d-do)
            #IFS=$'\n' 
            read -d '' -a columnTypeArr <<< $columntype
            read -d '' -a isPKArr <<< $isPK
            for i in $columnName
            do
            #check datatype of the input
                while true
                do
                    read -p "insert $i: " columnInput
                    
                    
                    #get the column data that we insert in
                    ((tempcount=$counter+1))
                    columnData=`awk -v temp=$tempcount '
                    BEGIN{FS=":"}
                    {
                        print $temp
                    }
                    ' $currentDatabase/$table/"$table"`

                    read -d '' -a columnDataArr <<< $columnData
                


                    #check for PK constrains
                    isPKAnswer=`isPK ${isPKArr[$counter]} $columnInput ${columnDataArr[@]}`
                    if [[ $isPKAnswer == "PK Repeated" ]]; then
                        echo "this attripute is Primary key and your input is repeated in the table "
                        continue  
                    fi



                    if [[ ${columnTypeArr[$counter]} == "number" ]]; then
                        if [[ $columnInput == +([0-9]) ]]; then
                            break
                        else
                            echo "this is not a number"
                        fi
                    elif [[ ${columnTypeArr[$counter]} == "string" ]]; then
                        if [[ $columnInput == +([a-zA-Z]) ]]; then
                            break
                        else
                            echo "this is not a string"
                        fi
                    else
                        echo "invalid Input"
                    fi

                done
                #echo without new line
                echo -n "$columnInput:" >> $currentDatabase/$table/"$table"

                ((counter=$counter+1))
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