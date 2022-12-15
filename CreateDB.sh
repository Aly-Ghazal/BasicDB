#!/bin/bash

echo "note that the name of the Database cannot contain spaces or any special character except "_" "
read  -p "now enter the name of your new Database: " name
source ./commonFunctions.sh
if [[ `checkStringForSpecialCharacter $name` = 1 ]]; then
    echo "we can't create a database its name contains special character or spaces "
else 
    mkdir $name
    echo "$name DB has been created"
fi