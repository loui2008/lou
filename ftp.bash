#!/bin/bash
##version=1.0
##makeer=lou
IP="192.168.2.100"
PORT="21"
USER="110"
PASSWORD="110"
YEAR=`date +%Y`
DATE=`date -d "yesterday" +%m%d`
for station in `seq 50001 50006`
do
	for i in `seq 1 4`
	do
	ftp  -i -n << EOF
		open $IP $PORT
		user $USER $PASSWORD
		bin
		mkdir /record/record_A$i/$YEAR/$DATE/%station
		cd /record/record_A$i/$YEAR/$DATE/%station
		lcd /record/record_A$i/$YEAR/$DATE/%station
		mput *
		close
		quit
		EOF
	done
done
