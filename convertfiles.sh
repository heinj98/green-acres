#!/bin/sh  

path="/home/james/Videos/Green Acres"
newpath="/home/james/Videos/Green Acres2"

mk_file () {
filename=$1
seasonum=$2
echo -n Recreating $filename from Season $seasonum...
ffmpeg -i "$path/Season $2/$filename" -nostdin -loglevel quiet -map 0:0 -map 0:2 -c copy "$newpath/Season $2/$filename" 
if [ $? -eq 0 ]; then
	echo OK
else
	echo FAILED
fi
}

cp_file () {
filename=$1
seasonum=$2
echo -n Copying $filename from Season $seasonum...
cp "$path/Season $2/$filename" "$newpath/Season $2/"
if [ $? -eq 0 ]; then
	echo OK
else
	echo FAILED
fi
}

for i in 1 2 3 4 5 6
        do
                while read filename
                        do
                                ffmpeg -i "$path/Season $i/$filename" -hide_banner 2>&1 | grep "#0:2" > /dev/null
                                RETVAL=$?
                                [ $RETVAL -eq 0 ] && mk_file "$filename" "$i"
                                [ $RETVAL -eq 1 ] && cp_file "$filename" "$i"
                        done < "$path/filelist/season$i.txt"
        done
