#!/bin/bash
echo ""
echo "NOTE that the name of the Table cannot contain spaces, any special character or starts with a number"
echo ""
source ./commonFunctions.sh
while true
do
    read  -p "now enter the name of your new table: " name
    if [[ $name = *" "*  ]]; then
            echo ""
            echo "we can't create a table its name contains spaces "
            echo ""
    else 
        if [[ `checkForSpecialCharacter $name` = 1 ]]; then
            echo ""
            echo "we can't create a table its name contains special characters "
            echo ""
        else
            if [[ `checkFirstChar $name` = 1 ]]; then
                echo ""
                echo "we can't create a table its name starts with number "
                echo ""
            else
                if [[ -d $currentDatabase/$name ]]; then
                    echo ""
                    echo "this table already exist"
                    echo ""
                else
                    if [[ $currentDatabase == $name ]]; then
                        echo ""
                        echo "you can't create a table with the same name of the DataBase"
                        echo ""
                    else
                        echo ""
                        mkdir $currentDatabase/$name
                        touch $currentDatabase/$name/"$name.metadata"
                        touch $currentDatabase/$name/"$name"
                        echo "$name table has been created"
                        echo ""
                        break
                    fi
                    
                fi
            fi
        fi
    fi
done

declare -i attributes
while true
do
read  -p "how many attributes you want to insert in the table " attributes
if [[ $attributes != +([1-9]) ]]; then
    echo ""
    echo "0 and non-numerical inputs not acceptable try again.."
    echo ""
else
    break
fi
done

isPK=0

for ((i=0; i<attributes; i++))
do
    while true
    do
    # this flag to break if column name is uniuqe
        flag=1
        read -p "column name: " columnName
        if [[ $columnName = *" "* || `checkForSpecialCharacter $columnName` = 1 || `checkFirstChar $columnName` = 1 ]]; then
            echo ""
            echo "we can't create a column its name contains spaces, special characters or starts with number "
            echo ""
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
                echo ""
                echo "this column has been created before please enter another name.."
                echo ""
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
        echo ""
        echo "column type is number"
        echo ""
        break
        ;;
        "string" )
        datatype="string"
        echo ""
        echo "column type is string"
        echo ""
        break
        ;;
        * )
        echo ""
        echo "please only choose number or string"
        echo ""
        esac
    done
    if [[ $isPK = 0 ]]; then
        while true
        do
            read -p "is this attribute will be your Primary Key[Y/N]: " PK
            if [[ $PK = [Yy] ]]; then
            # to be all recorded the same Y/N
                PK="Y"
                isPK=1
                break
            elif [[ $PK = [Nn] ]]; then
                PK="N"
                break
            else 
                echo ""
                echo "invalid character"
                echo ""
            fi
        done
    else
        PK="N"
    fi
echo "$columnName:$datatype:$PK" >> $currentDatabase/$name/"$name.metadata"
done
if [[ $isPK = 0 ]]; then
    #OFS keep field sperator as ":"
   Result=`awk -v OFS=: 'BEGIN{FS=":"}{
        if(NR==1){
            $3="Y"
        }
        print $0
        }' ./$currentDatabase/$name/"$name.metadata"` 
        echo "$Result" > ./$currentDatabase/$name/"$name.metadata"
fi
