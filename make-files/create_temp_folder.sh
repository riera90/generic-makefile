#!/bin/bash
#	script for the creation of the temporal fyles for the makefile
for file in $*; do
	#directory=$(echo $file | sed -rn 's/^(.*)$/\1/p')
	directory=$file
	if [[ -d $directory ]]; then
		echo "[already created] " $directory
	else
		if [[ "" != $directory ]]; then
			mkdir -p $directory
		fi
	fi
done
