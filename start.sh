#!/bin/sh -x

# Influxv2 is special and DEMANDS a home directory to run from or nothing works as intended, oh and you cant run as root either (at least "restore" will not work)
#mkdir -p /home/influxdb
#chown -R influxdb:influxdb /var/lib/influxdb
INFLUXDB="/var/lib/influxdb/"

# Drop the backup of your database somewhere (remember to have the influxdb-user on the system and owning all files) then restore with below
#runuser influxdb -c "/opt/local/bin/influxd restore --backup-path /home/influxdb/backup/today"

#FLAGS="--http-bind-address=0.0.0.0:9999 --log-level debug --reporting-disabled"
# FIXME: I'd want it to run with something similar to below but it doesnt work as intended, you can run it wherever you like... as long as it's in a users home directory 
FLAGS="--bolt-path ${INFLUXDB}.influxdbv2/influxd.bolt --engine-path ${INFLUXDB}.influxdbv2/engine --http-bind-address 127.0.0.1:9999 --log-level debug --reporting-disabled"
/usr/local/bin/influxd $FLAGS

### FIXME: This is just an ugly hack to try and migrate the database from influx2-beta to influx2-rc
#mv /home/influxdb/.influxdbv2 /home/influxdb/.influxdbv2_old
#FLAGS="--bolt-path /home/influxdb/.influxdbv2_old/influxd.bolt --engine-path /home/influxdb/.influxdbv2_old/engine --http-bind-address=0.0.0.0:9999 --log-level debug --reporting-disabled "
#runuser influxdb -c "/opt/local/bin/influxd_old $FLAGS &"
#runuser influxdb -c "/opt/local/bin/influxd --http-bind-address=0.0.0.0:8046 --log-level debug --reporting-disabled"

# FIXME: I'm not entirely sure why but whatever you do you'll end up with 2 databases, one in a semi-proper place (/var/lib/influxdb/.influxdbv2) and one in a static place (~/.influxdbv2).
#runuser influxdb -c "/opt/local/bin/influxd $FLAGS "
