#!/bin/sh

#VERIFICA ARGOMENTI
#servono almeno due argomenti
if test $# -lt 2 #tutti argomenti di test
then
    echo "Uso: contaricorrenze <file> <stringhe...>"
    exit 1
fi

#il primo argomento deve essere un file
file=$1
if test ! -f "$file" #tutti argomenti di test
then
    echo "Errore: il primo argomento deve essere un file"
    exit 2
fi

#elimino il primo argomento dalla lista (file), in $1 non avrò più il nome del file, ma l'argomento successivo
shift

#RICERCA PATTERN
echo Controllo file $file
for i in $* #controllo le sole stringhe passate come argomenti
do
    count=`grep "$i" "$file" | wc -l`
    echo "Parametro: $i - Ricorrenze: $count"
done