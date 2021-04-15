#!/bin/bash

# проверка на количество аргументов , должно быть 4
if [ $# -lt 4 ]; then
    echo "Arguments not found!"
    exit 1
fi

let weight=-1
let height=-1

while [ -n "${1}" ]; do  # пока аргументы есть 
    case "${1}" in
        --weight) weight=${2};;
        --height) height=${2};
    esac    # завершает case
    shift 2 # смещает параметр влево
done

# проверка на то, верно ли указаны параметры
if ! [ ${weight} -ne -1 -a ${height} -ne -1 ]; then
    echo "Arguments invalid!"
    echo "Example: "
    echo "./bmi.sh --height 90 --weight 186"
    exit 1
fi


# проверка переменной на число, с помощью регулярных выражений
re='^[0-9]+$'
if ! [[ ${height} =~ ${re} ]]; then
   echo "error: Height not a number"
   exit 1
fi
if ! [[ ${weight} =~ ${re} ]]; then
   echo "error: Weight not a number"
   exit 1
fi

echo "weight = ${weight}    height = ${height}" 

let height_squared=${height}*${height}
let BMI=" 703 * ${weight} / ${height_squared}"

echo "Index = ${BMI}"
echo -n "Weight class = "
if [ ${BMI} -le 18 ]; then
    echo "underweight"
elif [ ${BMI} -le 24 ]; then
    echo "normal"
elif [ ${BMI} -le 29 ]; then
    echo "overweight"
else
    echo "Obese"
fi
