#!/usr/bin/env bash

#Using the 'Australia/Sydney' timezone as an example

dateInQuestion=$3
dateInQuestionInUTC=`TZ=UTC date --iso-8601=seconds -d"{dateInQuestion} - 10 hours"`

if [ "$TZ" == "$DST_TZ" ]; then
	 INFO "DST is in effect for this date $TZ , using DST offsets"
    	dateInQuestionInUTC=`TZ=UTC date --iso-8601=seconds -d"{dateInQuestion} - 11 hours"`
fi

INFO "Date in UTC : ${dateInQuestionInUTC}"