#!/bin/bash
echo "now you are connected to $currentDatabase"
echo "please choose from the next list by number what do you want to do in $currentDatabase :) "
select i in "Create Table" "Show all Tables" "update Table" "Drop Table" "insert into a table" "back"
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
    #update Row##############
    "update Table" )
        . ./updateTable.sh
        . ./tableMenu.sh
    ;;
    "Drop Table" )
        . ./DropTable.sh
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
