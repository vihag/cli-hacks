#!/usr/bin/env bash

sed -i -r s#${regex_to_replace}#${value_to_replace_with}#g ${file_to_edit}