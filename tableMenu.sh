#!/bin/bash
echo "now you are connected to $currentDatabase"
echo "please choose from the next list by number what do you want to do in $currentDatabase :) "
select i in "Create Table" "select/display Record" "Show all Tables" "Drop table data only" "delete Record" "update Data in Column of table" "Drop Table" "Show Table Records" "insert into a table" "Disconnect"
do
case $i in
    "Create Table" )
        . ./CreateTable.sh
        . ./tableMenu.sh
    ;;
    "select/display Record" )
        . ./DisplayRecord.sh
        . ./tableMenu.sh
    ;;
    "Show all Tables" )
        echo ""
        ls -d ./$currentDatabase/*
        echo ""
        . ./tableMenu.sh
    ;;
    "Drop table data only" )
        echo "this will delete the data only not the metadata"
        . ./dropTableData.sh
        . ./tableMenu.sh
    ;;
    "delete Record" )
    . ./DeleteRecord.sh
    . ./tableMenu.sh
    ;;
    "update Data in Column of table" )
        . ./updateDataInColumn.sh
        . ./tableMenu.sh
    ;;
    "Drop Table" )
        . ./DropTable.sh
        . ./tableMenu.sh
    ;;
    "Show Table Records" )
        . ./showTable.sh
        . ./tableMenu.sh
    ;;
    "insert into a table" )
        . ./insertIntoTable.sh
        . ./tableMenu.sh
    ;;
    "Disconnect" )
        . ./main_program.sh
        break
    ;;
    * )
    echo "invalid option"
    . ./tableMenu.sh
esac
done
