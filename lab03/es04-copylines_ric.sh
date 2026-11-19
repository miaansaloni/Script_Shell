#!/bin/sh

cd "$1"
shift

for i in $*
do
    if test -f $i -a -r $i
    then
        if test `grep -c $STRINGA $i` -ge 1
        then
            echo `pwd`/$i >> /tmp/.riultati
            grep $STRINGA $i >> /tmp/.stringhe
            mv $i /tmp
        fi
    fi
done

for dir in*
do
    if test -d "$dir" -a -x "$dir"
    then
        es04-copylines_ric.sh "`pwd`/$dir" $*
    fi
done