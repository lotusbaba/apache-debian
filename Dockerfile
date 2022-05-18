FROM ubuntu:latest
VOLUME /tmp /root
#MAINTAINER Bhaskar Jayaraman jay.bhaskar@gmail.com

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles
RUN apt-get update
RUN apt-get --assume-yes install apache2
RUN apt-get --assume-yes install apache2-utils
RUN apt-get --assume-yes install rsyslog
RUN apt-get --assume-yes install sudo
RUN apt-get --assume-yes install systemctl
RUN apt-get --assume-yes install curl
RUN apt-get --assume-yes install sudo
RUN apt-get --assume-yes install vim

WORKDIR /root 

RUN mkdir certs
WORKDIR /root/certs
COPY ./certs/* /root/certs/

WORKDIR /etc
ADD apache2 /etc/apache2
RUN chmod +x /etc/apache2/pphrase

WORKDIR /var/www/
ADD html /var/www/html

EXPOSE 80 
EXPOSE 443
EXPOSE 514

ENTRYPOINT ["systemctl", "start", "apache2"]
