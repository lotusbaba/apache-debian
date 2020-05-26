FROM debian
VOLUME tmp root
MAINTAINER Bhaskar Jayaraman bhaskar@fastly.com

RUN apt-get update
RUN apt-get --assume-yes install apache2
RUN apt-get --assume-yes install rsyslog

WORKDIR /root 
RUN mkdir certs
WORKDIR /root/certs
COPY ./certs/* ./

WORKDIR /etc
COPY apache2/* /etc/apache2/

EXPOSE 80
EXPOSE 443
EXPOSE 514

CMD sudo a2enmod headers
CMD sudo a2enmod session
CMD sudo a2enmod ssl
CMD sudo a2enmod http2
CMD sudo chmod +x /etc/apache2/pphrase
CMD sudo service apache2 start
CMD sudo service rsyslog start
CMD sudo service rsyslog start
CMD sudo service syslog start
CMD sudo systemctl status syslog.service
