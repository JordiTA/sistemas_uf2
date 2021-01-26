#!/bin/bash

PORT=2021
IP_CLIENT="127.0.0.1"
IP_SERVER="127.0.0.1"

echo "(0) Server ABFP"

echo "(1) Listening $PORT"

nc -l -p $PORT

echo "(4) Response"

echo "OK_CONN" | nc -q 1 $IP_CLIENT $PORT
