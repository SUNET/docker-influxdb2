#!/bin/sh -x

printenv

if [ "x${HOSTNAME}" = "x" ]; then
   HOSTNAME="`hostname`"
fi

if [ "x${CERTDIR}" = "x" ]; then
   CERTDIR="/etc/dehydrated/certs"
fi

# With influx2 out of alpha/beta you can now run in a proper location, some artifacts remain of "/home/influx" but they will be removed
INFLUXDB="/var/lib/influxdb/"

# Debug log is not as spammy as one would think and --reporting-disabled is a good idea to opt-out of "calling home"
FLAGS="--bolt-path ${INFLUXDB}.influxdbv2/influxd.bolt --engine-path ${INFLUXDB}.influxdbv2/engine --http-bind-address 0.0.0.0:8086 --log-level debug --reporting-disabled --tls-cert=${CERTDIR}/${HOSTNAME}.crt --tls-key=${CERTDIR}/${HOSTNAME}.key"
/usr/local/bin/influxd $FLAGS
