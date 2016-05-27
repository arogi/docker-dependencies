FROM ubuntu:trusty

MAINTAINER Tim Niblett tniblett@arogi.com

#ENV APACHE_LOG_DIR /var/log/apache2

# This section gets the required dependecies we need to create our image
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -y -q
RUN apt-get install -y nano \
wget \
curl \
python \
python-dev \
python-pip \
apache2 \
libapache2-mod-python

#This section sets up Google OR-tools
RUN wget https://github.com/google/or-tools/releases/download/v2016-04/Google.OrTools.python.examples.3574.tar.gz && \
tar -xzf Google.OrTools.python.examples.3574.tar.gz && \
cd ortools_examples && \
python setup.py install && \
cd .. && \
rm -R ortools_examples && \
rm Google.OrTools.python.examples.3574.tar.gz && \
cd /usr/local/lib/python2.7/dist-packages && \
chown -R root:www-data * && \
chmod -R 755 *

# This section sets up GDAL/OGR and PROJ
RUN wget http://download.osgeo.org/gdal/2.1.0/gdal-2.1.0.tar.gz && \
wget http://download.osgeo.org/proj/proj-4.9.2.tar.gz && \
wget http://download.osgeo.org/proj/proj-datumgrid-1.5.tar.gz && \
tar -xzf proj-4.9.2.tar.gz && \
cd proj-4.9.2/nad && \
tar -xzf ../../proj-datumgrid-1.5.tar.gz && \
cd .. && \
./configure && \
make && \
make install && \
cd .. && \
rm -R proj-4.9.2 && \
tar -xzf gdal-2.1.0.tar.gz && \
cd gdal-2.1.0 && \
./configure --with-python && \
make && \
make install && \
ldconfig && \
cd .. && \
rm -R gdal-2.1.0

# Setup Apache2
RUN a2dismod mpm_event && \
a2enmod mpm_prefork cgid && \
cd /etc/apache2/sites-enabled/ && \
sed -i '1 a\  <Directory /var/www/test>' /etc/apache2/sites-enabled/000-default.conf && \
sed -i '2 a\     Options +ExecCGI' /etc/apache2/sites-enabled/000-default.conf && \
sed -i '3 a\  </Directory>' /etc/apache2/sites-enabled/000-default.conf && \
sed -i '4 a\  AddHandler cgi-script .py' /etc/apache2/sites-enabled/000-default.conf

# Import arogi examples
ADD http://sta.in/circuit-web/arogi_earth.css /var/www/html/
ADD http://sta.in/circuit-web/LICENSE.md /var/www/html/
ADD http://sta.in/circuit-web/README.md /var/www/html/
ADD http://sta.in/circuit-web/CONTRIBUTING.md /var/www/html/
ADD http://sta.in/circuit-web/style.yaml /var/www/html/
ADD http://sta.in/circuit-web/index.html /var/www/html/
ADD http://sta.in/circuit-web/data/cal_parks.geojson /var/www/html/data/mydata.geojson
ADD http://sta.in/circuit-web/data/data_LA10.geojson /var/www/html/data/
ADD http://sta.in/circuit-web/data/data_SB100.geojson /var/www/html/data/
ADD http://sta.in/circuit-web/data/data_SB14.geojson /var/www/html/data/
ADD http://sta.in/circuit-web/data/data_SB150.geojson /var/www/html/data/
ADD http://sta.in/circuit-web/data/data_SB200.geojson /var/www/html/data/
ADD http://sta.in/circuit-web/data/data_SB250.geojson /var/www/html/data/
ADD http://sta.in/circuit-web/data/data_SB500.geojson /var/www/html/data/
ADD http://sta.in/circuit-web/data/nps_parks.geojson /var/www/html/data/
ADD http://sta.in/circuit-web/images/ffffff.png /var/www/html/images/
ADD http://sta.in/circuit-web/images/poi_icons_18@2x.png /var/www/html/images/
ADD http://sta.in/circuit-web/images/tangle2.png /var/www/html/images/
ADD http://sta.in/circuit-web/interface/GISOps.pyc /var/www/html/interface/
ADD http://sta.in/circuit-web/interface/tsp_interface.txt /var/www/html/interface/tsp_interface.py
ADD http://sta.in/circuit-web/leaflet/leaflet-src.js /var/www/html/leaflet/
ADD http://sta.in/circuit-web/leaflet/leaflet.css /var/www/html/leaflet/
ADD http://sta.in/circuit-web/leaflet/leaflet.js /var/www/html/leaflet/
ADD http://sta.in/circuit-web/leaflet/images/layers-2x.png /var/www/html/leaflet/images/
ADD http://sta.in/circuit-web/leaflet/images/layers.png /var/www/html/leaflet/images/
ADD http://sta.in/circuit-web/leaflet/images/marker-icon-2x.png /var/www/html/leaflet/images/
ADD http://sta.in/circuit-web/leaflet/images/marker-icon.png /var/www/html/leaflet/images/
ADD http://sta.in/circuit-web/leaflet/images/marker-shadow.png /var/www/html/leaflet/images/

# Perform some cleanup
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
rm -rf /run/httpd/* /tmp/httpd* && \
chmod -R 755 /var/www/html/*

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
EXPOSE 8080
EXPOSE 443
