#!/bin/bash

PRANAYAMA_TIME=60
SECONDS_TO_BREATHE=3

while getopts ":p:s:m:" o; 
do
	case "$o" in
	p)	PRANAYAMA_TIME="$OPTARG";;
	s)	SECONDS_TO_BREATHE="$OPTARG";;
	m)      PRANAYAMA_TIME=`expr $OPTARG \* 60`;;
	[?])	echo "Usage: $0 [-p] seconds_to_pranayama (default 60) [-m] minutes_to_pranayama (default 1) [-s] base_count (default 3) [-v] voice (default Victoria)"
		exit 1;;
	esac
done

VOICE=Victoria
START=`date +%s`
FINISH_AT=`expr $PRANAYAMA_TIME + $START` 

breathe () 
{
	what=$1
	how_long=$2
	up_or_down=$3
	myseq=0

	if [ $up_or_down -eq 1 ]
	then
		myseq=`seq 2 $how_long`
	else
		myseq=`seq \`expr $how_long - 1\` 1`
	fi

	say -v $VOICE $what
	sleep 1
	for i in $myseq
	do
		say -v $VOICE $i
		sleep 1
	done
}

while [ `date +%s` -lt $FINISH_AT ]
do
	breathe "breathe in" $SECONDS_TO_BREATHE 1
	breathe "hold" $SECONDS_TO_BREATHE 1
	breathe "breathe out" $SECONDS_TO_BREATHE 1
	breathe "hold" $SECONDS_TO_BREATHE 1
done
