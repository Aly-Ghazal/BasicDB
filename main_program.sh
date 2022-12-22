#!/bin/bash
#Tasks...
# [1] Database
#       [*] delete Database
#       [*] list Databases
#       [*] create Database
#       [*] connect to Database
# [*] Tables
# [*] column
# [*] Data inside columns
echo "Welcome to BasicDB where you can insert, delete, create, update --> tables & Databases "
echo "please choose from the next list by number what do you want to do :) "
select i in "Create Database" "Show all Databases" "connect to Database" "Drop a Database" "exit"
do
case $i in
    "Create Database" )
        . ./CreateDB.sh
        . ./main_program.sh
    ;;
    "Show all Databases" )
        echo ""
        ls -F|grep "/"|cut -d "/" -f 1
        echo ""
        . ./main_program.sh
    ;;
    "connect to Database" )
        . ./ConnectDB.sh
        . ./main_program.sh
    ;;
    "Drop a Database" )
        . ./deleteDB.sh
        . ./main_program.sh
    ;;
    "exit" )
        echo "GOODBYE `whoami` ;) "
        exit
    ;;
    * )
        echo "unavilable option"
        . ./main_program.sh
esac
done