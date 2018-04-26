#!/usr/bin/env bash

hadoop fs -du -s -h /migrate/data/lbs_ndc/raw_20171219* | awk '{sum += $1} END {print sum}'
