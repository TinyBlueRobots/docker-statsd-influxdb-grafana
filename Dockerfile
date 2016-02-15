FROM centos:latest

#Influxdb 
RUN yum -y install https://s3.amazonaws.com/influxdb/influxdb-0.10.0-1.x86_64.rpm
COPY config/influxdb.conf /etc/influxdb/influxdb.conf

#Node
RUN curl --silent --location https://rpm.nodesource.com/setup_5.x | bash - \
    && yum -y install nodejs
    
#Statsd
RUN curl -L https://github.com/etsy/statsd/archive/v0.7.2.tar.gz \
    -o /tmp/statsd.tar.gz \
    && tar --strip-components 1 -zxf /tmp/statsd.tar.gz -C /usr/local \
    && rm /tmp/statsd.tar.gz \
    && npm install -y statsd-influxdb-backend
COPY config/statsd.js /usr/local

#Grafana
RUN yum -y install https://grafanarel.s3.amazonaws.com/builds/grafana-2.6.0-1.x86_64.rpm
COPY config/grafana.ini /etc/grafana/grafana.ini

RUN rm /var/tmp/**/*.rpm
RUN yum clean all

COPY config/grafanaDatasource.json /usr/local/grafanaDatasource.json

COPY start.sh /usr/local/start.sh

EXPOSE 3000 8083 8086 8125/udp 

CMD bash -C /usr/local/start.sh