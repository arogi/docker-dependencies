FROM tniblett/arogi-apache-cgi

MAINTAINER Tim Niblett tniblett@arogi.com

#ENV APACHE_LOG_DIR /var/log/apache2

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q

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
RUN chmod -R 755 /var/www/html/*
RUN rm -rf /run/httpd/* /tmp/httpd*

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
EXPOSE 8080
EXPOSE 443
