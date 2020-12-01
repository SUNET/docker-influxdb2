FROM ubuntu:20.10

RUN apt-get update && apt-get install -y --no-install-recommends wget

RUN wget --quiet --no-check-certificate https://dl.influxdata.com/influxdb/releases/influxdb_2.0.2_amd64.deb 
RUN tar xvfz influxdb-2.*linux_amd64.tar.gz
RUN mv -v influ*/influ* /usr/local/bin/
COPY start.sh /
RUN chmod a+rx /start.sh

### These lines below are for reasons of migration from ALPHA/BETA influx2 into RC influx2. Can (probably) be disabled any day now.
## The new binaries MUST be disabled and not started or Docker will exit due to non-backwardscompat database
# So in theory everything above SHOULD work after the migration has been done, the rows below are for future reference/use for migration
#RUN wget --quiet --no-check-certificate https://dl.influxdata.com/influxdb/releases/influxdb_2.0.0-beta.10_linux_amd64.tar.gz
#RUN tar xvzf influxdb_2.0.0-beta.10_linux_amd64.tar.gz
#RUN mv /opt/local/bin/influxd /opt/local/bin/influxd_new
#RUN mv /opt/local/bin/influx /opt/local/bin/influx_new
#RUN mv -v influ*/influ* /opt/local/bin/
#EXPOSE 8086
### END OF CRAZY MIGRATION

EXPOSE 8086 

ENTRYPOINT ["/start.sh"]
