#!/bin/bash
echo "now you are connected to $currentDatabase"
echo "please choose from the next list by number what do you want to do in $currentDatabase :) "
select i in "Create Table" "Show all Tables" "Drop table data only" "update Row" "Drop Table" "Show Table" "insert into a table" "back"
do
case $i in
    "Create Table" )
        . ./CreateTable.sh
        . ./tableMenu.sh
    ;;
    "Show all Tables" )
        ls -d ./$currentDatabase/*
        . ./tableMenu.sh
    ;;
    "Drop table data only" )
        echo "this will delete the data only not the metadata"
        . ./dropTableData.sh
        . ./tableMenu.sh
    ;;

    #update Row##############
    "update Row" )
        . ./updateRow.sh
        . ./tableMenu.sh
    ;;
    "Drop Table" )
        . ./DropTable.sh
        . ./tableMenu.sh
    ;;
    "Show Table" )
        . ./showTable.sh
        . ./tableMenu.sh
    ;;
    "insert into a table" )
        . ./insertIntoTable.sh
        . ./tableMenu.sh
    ;;
    "back" )
        . ./main_program.sh
        break
    ;;
    * )
    echo "invalid option"
    . ./tableMenu.sh
esac
done
