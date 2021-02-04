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

exit 0
