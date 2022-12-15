#!/bin/bash
echo "NOTE that the name of the Table cannot contain spaces, any special character or starts with a number"
read  -p "now enter the name of your new table: " name
source ./commonFunctions.sh

if [[ $name = *" "*  ]]; then
        echo "we can't create a table its name contains spaces "
else 
    if [[ `checkForSpecialCharacter $name` = 1 ]]; then
        echo "we can't create a table its name contains special characters "
    else
        if [[ `checkFirstChar $name` = 1 ]]; then
            echo "we can't create a table its name starts with number "
        else
            if [[ -d $currentDatabase/$name ]]; then
                echo "this table already exist"
                exit
            else
                mkdir $currentDatabase/$name
                touch $currentDatabase/$name/"$name.metadata"
                touch $currentDatabase/$name/"$name"
                echo "$name table has been created"
            fi
        fi
    fi
fi
declare -i attributes
while true
do
read  -p "how many attributes you want to insert in the table " attributes
if [[ $attributes != [1-9] ]]; then
    echo "0 and non-numerical inputs not acceptable try again.."
else
    break
fi
done



isPK=0

for ((i=0; i<attributes; i++))
do
while true
do
flag=1
    read -p "column name: " columnName
    if [[ $columnName = *" "* || `checkForSpecialCharacter $columnName` = 1 || `checkFirstChar $columnName` = 1 ]]; then
        echo "we can't create a column its name contains spaces, special characters or starts with number "
        flag=0
    fi
    columns=`awk '
                BEGIN{FS=":"}
                {
                    print $1
                }
                ' $currentDatabase/$name/"$name.metadata"`
    for q in $columns
    do
        if [[ $columnName = $q ]]; then
            echo "this column has been created before please enter another name.."
            flag=0
            break
        fi
    done
    if [[ $flag = 1 ]]; then
    break
    fi
done





    echo "now choose datatype of your column: "
    select columnType in "number" "string"
    do
        case $columnType in
        "number" )
        datatype="number"
        echo "column type is number"
        break
        ;;
        "string" )
        datatype="string"
        echo "column type is string"
        break
        ;;
        * )
        echo "please only choose number or string"
        esac
    done
    if [[ $isPK = 0 ]]; then
        while true
        do
            read -p "is this attribute will be your Primary Key[Y/N]: " PK
            if [[ $PK = [Yy] ]]; then
                PK="Y"
                isPK=1
                break
            elif [[ $PK = [Nn] ]]; then
                PK="N"
                break
            else 
                echo "invalid character"
            fi
        done
    else
        PK="N"
    fi
echo "$columnName:$datatype:$PK" >> $currentDatabase/$name/"$name.metadata"
done