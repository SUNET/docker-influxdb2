FROM ubuntu:20.10

RUN apt-get update && apt-get install -y --no-install-recommends wget

RUN wget --quiet --no-check-certificate https://dl.influxdata.com/influxdb/releases/influxdb-2.0.3_linux_amd64.tar.gz
RUN tar xvfz influxdb-2.*linux_amd64.tar.gz
RUN mv -v influ*/influ* /usr/local/bin/
COPY start.sh /
RUN chmod a+rx /start.sh

EXPOSE 8086 

ENTRYPOINT ["/start.sh"]
