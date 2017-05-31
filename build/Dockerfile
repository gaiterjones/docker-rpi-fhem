FROM resin/rpi-raspbian:jessie

MAINTAINER PAJ <paj@gaiterjones.com>

ENV DEBIAN_FRONTEND noninteractive

# Install utils
RUN set -x \
	&& apt-get update \
	&& apt-get -y --force-yes install perl wget apt-transport-https iputils-ping supervisor telnet usbutils ntpdate netcat \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get clean	

# Install perl packages
RUN set -x \
	&& apt-get update \
	&& apt-get -y --force-yes install \
	libalgorithm-merge-perl \
	libwww-perl \
	libcgi-pm-perl \
	sqlite3 \
	libjson-perl \
	libdbd-sqlite3-perl \
	libtext-diff-perl \
	libdevice-serialport-perl \
	libio-socket-ssl-perl \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get clean	

WORKDIR /opt/fhem
ENV FHEM_HOME /opt/fhem
RUN useradd -d "$FHEM_HOME" -u 1001 -m -s /bin/bash fhem && usermod -a -G dialout fhem

# Install FHEM
RUN set -x \
	&& cd /opt/fhem \
	&& wget http://fhem.de/fhem-5.8.deb \
	&& dpkg -i fhem-5.8.deb
	
# setup
RUN set -x \
	&& echo Europe/Berlin > /etc/timezone \
	&& dpkg-reconfigure tzdata \
	&& mkdir -p /var/log/supervisor \ 
	&& cd /opt/fhem \	
	&& rm fhem-5.8.deb \	
	&& tar -cvf ../fhem.tar *

COPY ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start-fhem.sh /usr/bin/start-fhem.sh
RUN chmod +x /usr/bin/start-fhem.sh

CMD bash -C '/usr/bin/start-fhem.sh';'bash'