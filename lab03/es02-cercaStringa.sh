#!/bin/sh
cd "$2"

> /tmp/.counter.tmp

for i in `ls *.txt 2>dev/null`
do
    if test -f "$i" -a -r "$i" -a `grep -c $1 "$i"` -ge $3
    then
        echo $i >> /tmp/.counter.tmp
    fi
done

if test `wc -l < /tmp/.counter.tmp` -gt `wc -l < /tmp/.max_counter.tmp`
then
    mv /tmp/.counter.tmp /tmp/.max_counter.tmp
fi

rm -f /tmp/.counter.tmp

for dir in *
do
    if test -d "$dir" -a -x "$dir"
    then
        es02-cercaStringa.sh "$1" "$dir" "$3"
    fi
done
