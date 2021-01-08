#!/bin/bash

PORT=8080

echo "Cliente"

echo "ola soi el  cliente" | cowsay | nc localhost $PORT