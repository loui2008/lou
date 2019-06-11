#！/bin/bash
host=$1
wait=$2

if [ -z $host ] ; then
	echo "Usahe: `basename $0 ` [HOST]"
	exit 1
fi

if [ -z $wait ] ; then
	wait=1
fi
let index=1
let lost=0
while :; do
	result=`ping -W l -c 1 $host | grep 'bytes from '`
	if [ $? -gt 0 ]; then
		echo -e "$lost/$index - `date +'%Y/%m/%d %H:%M:%S'` - host $host is \033
		[0;31mdown\033[0m"
		let lost=$lost+1
	else
		echo -e "$lost/$index - `date +'%Y/%m/%d %H:%M:%S'` - host $host is \033
		[0;32mok\033[0m - `echo $result | cut -d ':' -f 2`"
		sleep $wait # avoid ping rain
	fi
	let index=$index+1
done
