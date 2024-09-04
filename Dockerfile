FROM debian:bookworm

RUN apt-get update && apt-get install -y --no-install-recommends wget

RUN 'wget --quiet https://download.influxdata.com/influxdb/releases/influxdb2-2.7.10_linux_amd64.tar.gz' \
    && tar xvfz influxdb2-2.*linux_amd64.tar.gz \
    && cp influxdb2-2.*/usr/bin/influxd /usr/local/bin/ \
    && rm influxdb2-2.*linux_amd64.tar.gz \
    && rm -r influxdb2-2.*

COPY start.sh /

RUN chmod a+rx /start.sh

EXPOSE 8086 

ENTRYPOINT ["/start.sh"]
