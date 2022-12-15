#!/bin/bash
#Tasks...
# [1] Database
#       [*] delete Database
#       [*] list Databases
#       [1.3] create Database
#       [1.1] connect to Database
# [2] Tables
# [3] column
# [4] Data inside columns
echo "Welcome to BasicDB where you can insert, delete, create, update --> tables & Databases "
echo "please choose from the next list by number what do you want to do :) "
select i in "Create Database" "Show all Databases" "connect to Database" "Drop a Database"
do
case $i in
    "Create Database" )
        . ./CreateDB.sh
        break
    ;;
    "Show all Databases" )
        ls -F|grep "/"
        break
    ;;
    "connect to Database" )
        . ./ConnectDB.sh
        break
    ;;
    "Drop a Database" )
        . ./deleteDB.sh
        break
    ;;
    * )
        echo "unavilable option"
        . ./main_program.sh
esac
done