#/bin/bash
##copyright:lou
##version:1.0
year=`date +%Y`
day=`date -d 'yesterday'+%m%d`
IP='192.168.46.134'
for station in `seq 50001 50006`
do
	for i in `seq 1 4`
	do
	ssh root@$IP "mkdir -p /record/record_A$i/$year/$day/"
	if [ -d /record/record_A$i]/$year/$day/$station ] ; then
	echo "/record/record_A$i/$year/$day/$station"
	scp -l 5000 -r  /record/record_A$i/$year/$day/$station root@$IP:/record/record_A$i/$year/$day/$station
	fi
	done
done
