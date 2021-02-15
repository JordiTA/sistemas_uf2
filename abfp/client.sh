#!/bin/bash

PORT=2021
IP_CLIENT="127.0.0.1"
IP_SERVER="127.0.0.1"

echo "Cliente de ABFP"

echo "(2) Sending Headers"

echo "ABFP $IP_CLIENT" | nc -q 1 $IP_SERVER $PORT

echo "(3) Listening $PORT"

RESPONSE=`nc -l -p $PORT`s

if [ "$RESPONSE" != "OK_CONN" ]; then
	sleep 1
    echo "No se ha podido conectar con el servidor"
	exit 1
fi

echo "(6) HANDSHAKE"

sleep 1
echo "THIS_IS_MY_CLASSROOM" | nc -q 1 $IP_SERVER $PORT

echo "(7) LISTEN"
RESPONSEDOS=`nc -l -p $PORT`

if ["$RESPONSEDOS" != "YES_IT_IS"]; then
    
    sleep 1
    echo "KO_HANDSHAKE: No se ha podido conectar con el servidor."

    exit 1        
fi


echo "(10) FILE NAME"

MD5=`md5sum "salida.sh" | cut -d " " -f  2`  
echo "FILE_NAME salida.sh $MD5" | nc -q 1 $IP_SERVER $PORT

echo "(11) LISTEN"
RESPONSETRES=`nc -l -p $PORT`

if [ "$RESPONSETRES" != "OK" ]; then
echo "Error en el nombre del archivo"
exit 3
fi


echo "(14) DATA"

sleep 1 
echo "`cat "salida.sh" | nc -q 1 $IP_SERVER $PORT`"

echo "(15) LISTEN"
RESPONSECUATRO=`nc -l -p $PORT`

if [ "$RESPONSECUATRO" != "OK_DATA" ]; then
    echo "Error al enviar DATA"
    exit 1
fi


echo "(18) DESPEDIDA"

sleep 1
echo "ABFP GOOD_BYE" | nc -q 1 $IP_SERVER $PORT

exit 0
