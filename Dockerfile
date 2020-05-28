FROM ubuntu
VOLUME tmp root
MAINTAINER Bhaskar Jayaraman bhaskar@fastly.com

#RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles
#RUN apt-get install -y tzdata
RUN apt-get update
RUN apt-get --assume-yes install apache2
RUN apt-get --assume-yes install apache2-utils
RUN apt-get --assume-yes install rsyslog
RUN apt-get --assume-yes install systemctl

WORKDIR /root 
RUN mkdir certs
WORKDIR /root/certs
COPY ./certs/* ./

WORKDIR /etc
ADD apache2 /etc/apache2

WORKDIR /var/www/
ADD html /var/www/html

#COPY ./keyboard /etc/default/keyboard

EXPOSE 80
EXPOSE 443
EXPOSE 514

CMD ["a2enmod", "headers"]
CMD ["a2enmod", "session"]
CMD ["a2enmod", "ssl"]
CMD ["a2enmod", "http2"]
CMD chmod +x /etc/apache2/pphrase
CMD ["service", "apache2", "start"]
CMD ["service", "rsyslog", "start"]
CMD ["service", "syslog", "start"]
CMD ["systemctl", "status", "syslog.service"]
