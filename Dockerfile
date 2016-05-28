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
  libapache2-mod-python \
  python-numpy \
  python-scipy \
  git

#This section sets up Google OR-tools
RUN pip install numpy && \
  wget https://github.com/google/or-tools/releases/download/v2016-04/Google.OrTools.python.examples.3574.tar.gz && \
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
  sed -i '1 a\  <Directory /var/www/html>' /etc/apache2/sites-enabled/000-default.conf && \
  sed -i '2 a\     Options +ExecCGI' /etc/apache2/sites-enabled/000-default.conf && \
  sed -i '3 a\  </Directory>' /etc/apache2/sites-enabled/000-default.conf && \
  sed -i '4 a\  AddHandler cgi-script .py' /etc/apache2/sites-enabled/000-default.conf

# Import arogi examples
RUN git clone --depth=1 --single-branch --branch=master https://github.com/arogi/circuit-web.git && \
  cd circuit-web && \
  cp -R * /var/www/html && \
  cd .. && \
  rm -R circuit-web/

# Perform some cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  rm -rf /run/httpd/* /tmp/httpd* && \
  chmod -R 755 /var/www/html/*

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
EXPOSE 8080
EXPOSE 443
