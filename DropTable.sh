#!/bin/bash
echo ""
echo ""
echo "here is your Available Tables..."
echo ""
echo `ls -d ./$currentDatabase/*|rev|cut -d "/" -f 1|rev`
echo ""
read -p "please write which of these Tables do you want to drop: " Table
if [[ -d $currentDatabase/$Table ]]; then
    rm -r $currentDatabase/$Table
    echo "$Table has been droped"
else
    echo "there is no table with such a name"
fi