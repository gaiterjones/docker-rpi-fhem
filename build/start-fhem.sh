#!/bin/bash

# check if fhem src present in volume
installcheck=/opt/fhem/fhem.cfg

set -x

if [ -e "$installcheck" ]; then
	echo "fhem found in volume..."
else 
	echo "Installing fhem source files into volume..."
    cd /opt/fhem
	tar -xvf ../fhem.tar
fi 

echo "Starting fhem..."

/usr/bin/supervisord
