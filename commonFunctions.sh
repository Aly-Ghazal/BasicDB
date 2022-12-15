#!/bin/bash
shopt -s extglob
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