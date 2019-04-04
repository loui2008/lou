#!/bin/bash
year=`date +%Y`
day=`date -d 'yesterday' +%m%d`
for station in `seq 50001 50099`
do 
	##PWD=`cd /record/record_A$i/$year/$day/$station`
	for i in `seq 1 4`
	do
		if [ -d /record/record_A$i/$year/$day/$station ] ; then
		echo "/record/record_A$i/$year/$day/$station"
		##scp -l 5000 -r /record/record_A$i/$year/$day/$station root@10.118.5.180:/record/record_A$i/$year/$day/$station
		fi
	done
done 