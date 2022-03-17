#!/bin/bash

cd build/web

PORT=5000

echo 'Starting server on port' $PORT '...'
python3 -m http.server $PORT