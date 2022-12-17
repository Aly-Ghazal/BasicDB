# PROBLEM: SELECT FIELD IN AWK BY VARIABLE..


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
   
    columns=`awk 'BEGIN{FS=":"}{print $1}' ./$currentDatabase/$table/"$table.metadata"`
    echo ""
    echo "$columns"
    while true
    do
        read -p "which column you want to update with: " columnSelected
        if [[ $columns == *$columnSelected* ]]; then
            break
        else
            echo "This column doesn't exist in this table"
        fi
    done

    columnNum=`awk -v tempselected=$columnSelected 'BEGIN{FS=":"}{
        if(tempselected==$1){
            print NR
        }
        }' ./$currentDatabase/$table/"$table.metadata"`
        read -p "enter what do you want to replace: " replace
        read -p "enter its replacement: " replacement



    PK=`awk -v tempselected=$columnSelected 'BEGIN{FS=":"}{
        if(tempselected==$1){
            print $3
        }
        }' ./$currentDatabase/$table/"$table.metadata"`
        
        if [[ $PK == "Y" ]]; then
            #$columnNumber==${# of wanted field}
            PKexist=`awk -v columnNumber="$columnNum" -v Replacement=$replacement '
            BEGIN{FS=":"}{

            if(Replacement == $columnNumber ){
                print "false"
            }
            else{
                print "true"
            }
            }
            ' ./$currentDatabase/$table/"$table"`
            if [[ $PKexist == *"false"* ]]; then
                echo "this value already exist and this attribute is unique(primary key)"
                break
            else
            #sed -i "s/\<"$replace"\>/"$replacement"/g" "$currentDatabase/$table/$table"
            #var=`awk -v P=$replace -v RP=$replacement -v columnNumber="$columnNum" 'BEGIN{FS=":"}{ gsub(P,RP,$columnNumber);  print }' ./$currentDatabase/$table/"$table"` #> ./$currentDatabase/$table/"$table"
            #echo "$var"
            echo "replaceing process finished"
            #extract column
            declare -a var=(`awk -v columnNumber="$columnNum" 'BEGIN{FS=":"}{ print $columnNumber }' ./$currentDatabase/$table/"$table"`)
            
            echo "${var[@]}"
            #edit it
            for ((i=0; i<${#var[@]}; i++))
            do
                if [[ $replace = ${var[$i]} ]]; then
                    var[$i]=$replacement
                fi
            done
            echo "${var[@]}"
            #apply them [NEED TO BE FIXED]
            res=awk -v FinalAdj=$var -v columnNumber="$columnNum" 'BEGIN{FS=":"}{ $columnNumber=$FinalAdj[NR] }' ./$currentDatabase/$table/"$table" #> ./$currentDatabase/$table/"$table.tmp"|mv ./$currentDatabase/$table/"$table.tmp" ./$currentDatabase/$table/"$table"
            echo "$res"
            break
            fi
        else
            #sed -i "s/\<"$replace"\>/"$replacement"/g" "$currentDatabase/$table/$table"
            echo "replaceing process finished"

        fi

break
done