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
#metadata --> PK

#data itself --> column to be searched in
#new input

isPK(){
    if [[ $1 == "Y" ]]; then
    #Loop all arguments except first and second ones
        for i in "${@:3}"
        do
            if [[ $2 = $i ]]; then
                echo "PK Repeated"
                return
            fi
        done
        
    echo "Not PK or PK uniqe"
    return

}