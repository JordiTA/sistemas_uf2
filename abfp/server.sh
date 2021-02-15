#!/bin/bash

PORT=2021
IP_CLIENT="127.0.0.1"
IP_SERVER="127.0.0.1"

echo "(0) Server ABFP"

echo "(1) Listening $PORT"

HEADER=`nc -l -p $PORT`

echo "!TEST! $HEADER"

PREFIX=`echo $HEADER | cut -d " " -f 1`
IP_CLIENT=`echo $HEADER | cut -d " " -f 2`

echo "(4) RESPONSE"

if [ "$PREFIX"!="ABFP" ]; then
	echo "Error en la cabecera"
	
	sleep 1
	echo "KO_CONN" | nc -q 1 $IP_CLIENT $PORT

	exit 1
fi

echo "OK_CONN" | nc -q 1 $IP_CLIENT $PORT


echo "(5) LISTEN"
HANDSHAKE=`nc -l -p $PORT`

if [ "$HANDSHAKE" != "THIS_IS_MY_CLASSROOM"]; then
	echo "Error en el HANDSHAKE"

	sleep 1
	echo "KO_HANDSHAKE" | nc -q 1 $IP_CLIENT $PORT

	exit 1
fi


echo "(8) RESPONSE.DOS"

sleep 1
echo "YES_IT_IS" | nc -q 1 $IP_CLIENT $PORT


echo "(9) LISTEN"
FILENAME=`nc -q 1 $IP_CLIENT $PORT`

NAME=`echo $FILE_NAME | cut -d " " -f 2`
MD5_NAME=`echo $FILE_NAME | cut -d " " -f 3`


echo "(12) RESPONSE"

MD5=`md5sum $NAME | cut -d " " -f 2`

if [ "$MD5" != "$MD5_NAME" ]; then 
    echo "Error en el nombre del archivo"
    
    sleep 1
    echo "KO_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT
    exit 1
fi

sleep 1
echo "OK_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT


echo "(13) LISTEN"
`nc -l -p $PORT` > entrada.sh

cat entrada.sh
echo "(16) RESPONSE"

exit 0