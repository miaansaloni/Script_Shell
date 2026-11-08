#soluzione alternativa

#!/bin/sh

while true
do
    #lettura pattern
    echo "Scrivi il nome del file inserisci 'fine' per uscire":
    read nomefile
    if test "$nomefile" = fine;
    then
        echo Ricevuta richiesta di terminazione.
        exit 0 #termina immediatamente con successo, non come anomalia
    fi

    #ricerca pattern
    if test -f "$nomefile"
    then
        echo $nomefile è un file
    else
        if test -d "$nomefile"
        then
            echo "$nomefile è un direttorio"
        else
            echo "$nomefile non esiste"
        fi
    fi
done