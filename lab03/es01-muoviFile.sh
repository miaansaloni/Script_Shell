#!/bin/sh
# interfaccia: muoviFile num dirSorgente dirDestinazione ext1 ext2...extN

#controllo parametri
if test $# -lt 4
then
    echo uso: muoviFile num dirSorgente dirDestinazione ext1 ext2...extN
    exit 1
fi

case $1 in
    *[!0-9]*) echo uso: muoviFile num dirSorgente dirDestinazione ext1 ext2...extN
            echo num deve essere un numero
            exit 2;;
esac

num=$1
shift

# controllo parametro corrente (dirSorgente)
case $1 in
    /*) if test ! -d $1
        then
            echo uso: muoviFile num dirSorgente dirDestinazione ext1 ext2...extN
            echo dirSorgente deve essere una directory
            exit 3
        fi
    *) echo so: muoviFile num dirSorgente dirDestinazione ext1 ext2...extN
        echo dirSorgente deve essere un path assoluto
        exit 4;;
esac

sorg=$1
shift

# controllo parametro corrente (dirDestinazione)
case $1 in
    /*) if test ! -d $1
        then
            echo uso: muoviFile num dirSorgente dirDestinazione ext1 ext2...extN
            echo dirDestinazione deve essere una directory
            exit 5
        fi
    *) echo uso: muoviFile num dirSorgente dirDestinazione ext1 ext2...extN
        echo dirDestinazione deve essere un path assoluto
        exit 6;;
esac

dest=$1
shift

# controllo argomenti successivi (estensioni file)
for ext in $*
do
    case $ext in 
        .*);;
        *) echo uso: muoviFile num dirSorgente dirDestinazione ext1 ext2...extN
            echo "I vari ext* devono essere delle estensioni (quindi iniziare con '.')"
            exit 7;;
    esac
done

#estensione del PATH
PATH=$PATH:`pwd`
export PATH

#creazione di un file temporaneo in cui salvare i risultati parziali
>/tmp/.counter.tmp

#chiamata ricorsiva
es01-ricerca.sh $num "$sorg" "$dest" $*
echo `wc -l < /tmp/.counter.tmp`

#rimozione del file temporaneo per pulizia
rm -f /tmp/.counter.tmp
