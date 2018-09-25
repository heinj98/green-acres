#!/bin/sh
path="/home/james/Videos/Green Acres"
for i in 1 2 3 4 5 6
	do
	find "$path/Season $i" -type f -name '*.avi' >> /tmp/filelist.txt
	while read line
		do
			filename=$(basename "$line")
			echo $filename >> /tmp/filelist2.txt
		done < /tmp/filelist.txt
	sort -n --field-separator=x --key=2,2 /tmp/filelist2.txt >> "$path/filelist/season$i.txt"
	rm -rf /tmp/filelist.txt /tmp/filelist2.txt
	done
