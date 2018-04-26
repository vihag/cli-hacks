#!/usr/bin/env bash

fileAvailable=0

    while [ ${fileAvailable} -ne 1 ]
    do

      if [ ! -f "${folderToMonitor}/${fileToMonitor}" ]; then
           INFO "${fileToMonitor} is not yet available at ${folderToMonitor}"
           fileAvailable=0
      else
            data=`cat "${folderToMonitor}/${fileToMonitor}"`
            INFO "${fileToMonitor} is available at ${folderToMonitor}"
            fileAvailable=1
      fi

      sleep 60
    done