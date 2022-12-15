#!/bin/bash

echo "note that the name of the Database cannot contain spaces or any special character "
read  -p "now enter the name of your new Database: " name
source ./commonFunctions.sh
if [[ $name = *" "*  ]]; then
        echo "we can't create a database its name contains spaces "
else 
    if [[ `checkForSpecialCharacter $name` = 1 ]]; then
        echo "we can't create a database its name contains special characters "
    else
        if [[ -d $name ]]; then
            echo "this Database already exist"
        else
            mkdir $name
            echo "$name DB has been created"
        fi
    fi
fi