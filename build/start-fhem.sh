#!/bin/bash

# check if fhem src files are present in volume
# if not present install from tar created by image
#

installcheck=/opt/fhem/fhem.cfg

set -x

if [ -e "$installcheck" ]; then
	echo "fhem found in volume..."
else 
	echo "Installing fhem source files into volume..."
	chown -R fhem.dialout /opt/fhem
	chmod -R 755 /opt/fhem
    cd /opt/fhem
	tar -xvf ../fhem.tar
fi 

echo "Starting fhem..."

/usr/bin/supervisord
