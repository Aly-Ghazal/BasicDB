#!/bin/bash

echo "NOTE that the name of the Database cannot contain spaces, any special character or starts with number"
read  -p "now enter the name of your new Database: " name
source ./commonFunctions.sh

if [[ $name = *" "*  ]]; then
        echo "we can't create a database its name contains spaces "
else 
    if [[ `checkForSpecialCharacter $name` = 1 ]]; then
        echo "we can't create a database its name contains special characters "
    else
        if [[ `checkFirstChar $name` = 1 ]]; then
            echo "we can't create a database its name starts with number "
        else
            if [[ -d $name ]]; then
                echo "this Database already exist"
            else
                mkdir $name
                echo "$name DB has been created"
            fi
        fi
    fi
fi
