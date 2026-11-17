#!/bin/sh

if test $# -ne 1
then
    echo "Errore numero argomenti"
    exit 1
fi

case $1 in
    /*) echo Errore: il percorso non è relativo; exit 2;;
    *);;
esac

if test ! -d "$1" -o ! -x "$1"
then
    echo Errore: $1 non è una directory o non ho i diritti di accesso
    exit 2
fi

PATH=$PATH:`pwd`
export PATH

echo `0` > /tmp/.max_counter
> /tmp./max_dirname

es03-cancella_versioni_preliminari_aux.sh "`pwd`"/"$1"

echo "La directory che conteneva il maggior numero di file cancellati è: `cat /tmp/.max_dirname`"

rm -f /tmp/.max_counter
rm -f /tmp./max_dirname