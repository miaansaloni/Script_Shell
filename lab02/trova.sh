#!/bin/sh

#VERIFICA ARGOMENTI
#due argomenti
if test $# != 2
then
    echo "Uso: trova <dir> <file>"
    exit 1
fi

#il primo argomeno deve essere una directory assoluta
dir="$1"
case "$dir" in
    /*) ;;
    *) echo "Errore: il primo argomento deve essere una directory assoluta"
    exit 2;;
esac

if test ! -d "$dir" #"se non è vero che dir è un file di tipo directory"
then
    echo "Errore: il primo argomento non è una directory"
    exit 3
fi

#RICERCA
file="$2"
PATH=$PATH:`pwd` #aggiunge directory script corrente al PATH
export PATH #esporta il PATH

#verifica se ho i permessi per entrare in una directory
if test -x "$dir"
then
    cd "$dir"
    for i in *
    do
        if test -d "$i"
        then
            #RICORSIONE
            trova.sh "`pwd`"/"$i" "$file"
        else
            if test -f "$i" -a "$i" = "$file"
            then
                echo trovato $i in `pwd`
            fi
        fi
    done
fi