#!/bin/bash
echo ""
echo ""
echo `ls -F|grep "/"`
echo ""
echo ""
read -p "please write which of these Databases do you want to drop: " Database
if [[ -d $Database ]]; then
    rm -r $Database
    echo "$Database has been droped"
else
    echo "there is no database with such a name"
fi
