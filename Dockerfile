FROM ubuntu:20.10

RUN apt-get update && apt-get install -y --no-install-recommends wget

RUN wget --no-check-certificate https://dl.influxdata.com/influxdb/releases/influxdb_2.0.0-beta.10_linux_amd64.tar.gz
RUN tar xvfz influxdb_2.0.0-beta.10_linux_amd64.tar.gz
RUN mkdir -p /opt/local/bin 
RUN mv influ*/influ* /opt/local/bin/
COPY start.sh /
RUN chmod a+rx /start.sh

EXPOSE 9999

ENTRYPOINT ["/start.sh"]
