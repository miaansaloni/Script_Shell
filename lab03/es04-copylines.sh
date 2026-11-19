#!/bin/sh

str_err="es04-copylines nome_dir_assoluto stringa nomefile1 nomefile2 ... nomefileN"

if test $# -lt 3
then
    echo "Errore, numero di argomenti deve essere almeno 3"
    echo "Lanciare come $str_err"
    exit 1
fi

case $1 in
    /*) ;;
    *) echo "Errore: il percorso di $1 non è assoluto"; exit 2;;
esac

dir="$1"; shift
STRINGA=$1; shift

for par in $*
do
    case $par in
        *[!a-z]*) echo "Errore i nomi di file non possono contenere caratteri diversi da quelli minuscoli";
                exit 3;;
            *);;
    esac
done   

PATH=$PATH:`pwd`
export PATH
export STRINGA

> /tmp/.risultati
> /tmp/.stringhe

while true
do
    es04-copylines_ric.sh "$dir" $*

    num_ris=`cat /tmp/.risultati | wc -l`
    if test $num_ris -gt 0
    then
        echo "sono stati spostati $num_ris file"
        cat /tmp/.stringhe
        rm -f /tmp/.risultati /tmp/.stringhe
        exit 0
    else
        echo "Nessun file trovato che crrisponde alle richieste. Attendo un'ora..."

        sleep `expr 60 \* 60`
    fi
done
