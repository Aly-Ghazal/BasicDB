#!/bin/bash
echo ""
echo "those are your created Databases: "
echo ""
echo `ls -F|grep "/"|cut -d "/" -f 1`
echo ""
echo ""
read -p "please enter which of these Databases do you want to use: " Database
if [[ -d $Database ]]; then
    export currentDatabase=$Database
    . ./tableMenu.sh
else
    echo "there is no database with such a name"
    . ./main_program.sh
fi
