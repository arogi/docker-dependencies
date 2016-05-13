FROM tniblett/arogi-apache-cgi

MAINTAINER Tim Niblett tniblett@arogi.com

ENV APACHE_LOG_DIR /var/log/apache2

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q

ADD http://sta.in/dockerDemo/ajax_functions.js /var/www/html/
ADD http://sta.in/dockerDemo/arogi_dark.css /var/www/html/
ADD http://sta.in/dockerDemo/grayprint.yaml /var/www/html/
ADD http://sta.in/dockerDemo/index.html /var/www/html/
ADD http://sta.in/dockerDemo/images/dots.svg /var/www/html/images/
ADD http://sta.in/dockerDemo/images/ffffb2.png /var/www/html/images/
ADD http://sta.in/dockerDemo/images/poi_icons_18@2x.png /var/www/html/images/
ADD http://sta.in/dockerDemo/interface/GISOps.pyc /var/www/html/interface/
ADD http://sta.in/dockerDemo/interface/tsp_interface.txt /var/www/html/interface/tsp_interface.py
ADD http://sta.in/dockerDemo/interface/GISOps.pyc /var/www/html/interface/
ADD http://sta.in/dockerDemo/leaflet/leaflet-src.js /var/www/html/leaflet/
ADD http://sta.in/dockerDemo/leaflet/leaflet.css /var/www/html/leaflet/
ADD http://sta.in/dockerDemo/leaflet/leaflet.js /var/www/html/leaflet/
ADD http://sta.in/dockerDemo/leaflet/images/layers-2x.png /var/www/html/leaflet/images/
ADD http://sta.in/dockerDemo/leaflet/images/layers.png /var/www/html/leaflet/images/
ADD http://sta.in/dockerDemo/leaflet/images/marker-icon-2x.png /var/www/html/leaflet/images/
ADD http://sta.in/dockerDemo/leaflet/images/marker-icon.png /var/www/html/leaflet/images/
ADD http://sta.in/dockerDemo/leaflet/images/marker-shadow.png /var/www/html/leaflet/images/
RUN chmod -R 755 /var/www/html/*

CMD ["/usr/sbin/apache2ctl", "-D",  "FOREGROUND"]

EXPOSE 80
EXPOSE 8080
EXPOSE 443
EXPOSE 22
