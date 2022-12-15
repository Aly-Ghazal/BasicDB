#!/bin/bash
shopt -s extglob
#check for special character
checkForSpecialCharacter(){
    if [[ $1 = +(*['!'@#\$%^\&*()_+]*) ]]; then        
        echo 1
    else
        echo 0
    fi
}
#POISX regular expression
: '
checkSpaces(){
    if [[ $1 = +([:space:]) ]]; then        
        echo 1
    else
        echo 0
    fi
}
'
#check if first char is number
checkFirstChar(){
    if [[ ${1:0:1} = [0-9] ]]; then
        echo 1
    else
        echo 0
    fi
}