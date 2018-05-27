#!/bin/bash
# --------------------------------------------------------------------------
# Execution method:
# ./monitor_folder_size.sh <FOLDER> <MAX_FOLDER_SIZE_BY_GIGABYTES>
#
# Example:
# ./monitor_folder_size.sh /logs/logs/Archive 20
# --------------------------------------------------------------------------


function get_size_bytes {
    du -b $1 | awk '{print $1}'
}

function get_size_gigabytes {
    du -sh $1 | awk '{print $1}'
}


FOLDER=$1

MAX_FOLDER_SIZE_GIGA=$2
MAX_FOLDER_SIZE=$((MAX_FOLDER_SIZE_GIGA*1073741824))

# Check Folder Size
FOLDER_SIZE="$(get_size_bytes $FOLDER)"								

# Writing the results to log file
SIZE_HUMAN_READABLE=$(get_size_gigabytes $FOLDER)
echo $(date +"%Y-%m-%d %H:%M:%S")' - Starting Folder Size:  ' $SIZE_HUMAN_READABLE >> monitor_folder_size.log 

while (($FOLDER_SIZE > $MAX_FOLDER_SIZE)); 
do
	DELFILE="$(find $FOLDER -type f -printf '%T+ %p\n' | sort | head -n 1 | awk '{print $2}')"	# Path of the oldest file in the directory
	rm $DELFILE	
	
	# Check folder size after deletion
	FOLDER_SIZE="$(get_size_bytes $FOLDER)";							
done

# Writing the results to log file
SIZE_HUMAN_READABLE=$(get_size_gigabytes $FOLDER)
echo $(date +"%Y-%m-%d %H:%M:%S")' - Ending Folder Size:  ' $SIZE_HUMAN_READABLE >> monitor_folder_size.log

