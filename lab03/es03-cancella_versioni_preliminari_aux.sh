#!/bin/sh

cd "$1"

for i in *.txt
do
    if test -f "$i" -a -w "$i"
    then
        if test `head -n 1 $i | cut -f 3 -d `,`` = preliminare
        then
            echo "`pwd`/$i è preliminare"
            #rm -f "$i"
            counter=`expr $counter + 1`
        else
            echo "`pwd`/$i è definitivo"
        fi
    fi
done

if test $counter -gt `cat /tmp/.max_counter`
then 
    echo $counter > /tmp/.max_counter
    echo `pwd` > /tmp./max_dirname
fi

for d in *
do
    if test -d "$d" -a -x "$d"
    then
        es03-cancella_versioni_preliminari_aux.sh "$d"
    fi
done