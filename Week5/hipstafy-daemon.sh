# /bin/bash

print_help() {
  echo "\
Usage: $(basename "$0") accepts a single keyword:
start | stop | status | restart
as an argument.

Arguments explanations:
-----------------------
start:	 	start the daemon
stop:	 	stop the daemon
status:	 	check whether the daemon is still alive
restart: 	restart the daemon
--help:		print this message"
}

hipstafyDir="$HOME/Desktop/hipstafy/"
context="$(pwd)"

lockName="$(echo $0 | awk '{print $NF}' FS='/')"
lockDir="/var/lock/"
lockFile="$lockDir$lockName.pid"
touch "$lockFile"

logName="$0"
logDir="/var/log/"
outLogFile="$logDir$logName.out.log"
errLogFile="$logDir$logName.err.log"
touch "$outLogFile"
touch "$errLogFile"

oldPID="$(cat $lockFile)"
#will be 0 if older pid exists
olderExist="$(kill -0 $oldPID > /dev/null 2>&1; echo "$?")"


start_daemon() {
	#note: moving out of any unmountable fs would be preferrable, but we would need to move all
	#dependencies of this script to the $PATH in order to do so... hardly worth it
	#signal HUP (1): do nothing
	trap ' ' 1
	nohup ./hipstafy-wait.sh "$hipstafyDir" > "$outLogFile" 2> "$errLogFile" &
	newPID="$!" 
	echo "$newPID" > "$lockFile"
}

stop_daemon() {
	#remove lock
	rm -f "$lockFile"
	#kill all child processes :)
	pkill -TERM -P "$oldPID"
}

start() {
	if [ $olderExist -eq 0 ]; then
		echo "Daemon is already running. See --help for more info."
		exit 1
	fi
	start_daemon
	exit 0
}

stop() {
	#if no older exists
	if [ $olderExist -ne 0 ]; then
		echo "No daemon running. See --help for more info."
		exit 1
	fi
	stop_daemon
	exit 0
}
 
status() {
	#echo "old pid is $oldPID"
	#echo "olderExist is $olderExist"
	if [ $olderExist -eq 0 ]; then
		echo "Daemon is alive with pid $oldPID"
	else
		echo "Daemon is not alive"
	fi
	exit 0
}

restart() {
	if ! [ $olderExist -eq 0 ]; then
		echo "No daemon running. See --help for more info."
		exit 1
	fi
	stop_daemon
	start_daemon
	exit 0
}


if [ $# -gt 1 ] || [ $# -lt 1 ]; then
	echo "Incorrect number of params. See --help for more info."
fi

case $1 in
"start")
	start
	;;
"stop")
	stop
	;;
"status")
	status
	;;
"restart")
	restart
	;;
"--help")
	print_help
	exit 0
	;;
*)
	echo "Invalid param \"$1\". See --help for more info."
	;;
esac