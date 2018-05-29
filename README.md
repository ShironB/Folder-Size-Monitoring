Monitoring the folder size and making sure it doesn't pass the pre-defined size.
In case the folder is bigger then the defined size the script deletes the oldest files until reaching the threshold size.

# Execution method:

 ./monitor_folder_size.sh <FOLDER> <MAX_FOLDER_SIZE_BY_GIGABYTES>


# Example:

# ./monitor_folder_size.sh /logs/logs/Archive 20
