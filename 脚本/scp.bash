#/bin/bash
##copyright:lou
##version:1.0
year=`date +%Y`
day=`date -d yesterday +%m%d`
IP='192.168.46.134'
for station in `seq 50001 50006`
do
	for i in `seq 1 4`
	do
	if [ -d "/record/record_A$i/$year/$day/$station" ] ; then
	echo "dir is exist :/record/record_A$i/$year/$day/$station">>file.txt
	ssh root@$IP mkdir -p /record/record_A$i/$year/$day/ >>/home/log.txt 2>&1
	scp -l 5000 -r  /record/record_A$i/$year/$day/$station root@$IP:/record/record_A$i/$year/$day/$station  >>/home/log.txt 2>&1
	fi
	done
done
