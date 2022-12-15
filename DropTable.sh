#!/bin/bash
echo ""
echo ""
echo `ls -d $currentDatabase/*`
echo ""
echo ""
read -p "please write which of these Tables do you want to drop: " Table
if [[ -d $currentDatabase/$Table ]]; then
    rm -r $currentDatabase/$Table
    echo "$Table has been droped"
else
    echo "there is no table with such a name"
fi