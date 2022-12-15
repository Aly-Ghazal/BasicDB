#!/bin/bash
shopt -s extglob
checkStringForSpecialCharacter(){
    if [[ $1 = +(*['!'@#\$%^\&*()_+]*) ]]; then
        
        echo 1
    else
        
        echo 0
    fi
}
