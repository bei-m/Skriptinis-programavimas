#!/bin/bash

#create directory to store log file(s)
mkdir logs

#get current date and time
date="$(date '+%F')"
time="$(date '+%T')"

#read all processes into an array
IFS=$'\n' read -r -d '' -a processes < <(ps aux)

if [ $# -eq 1 ] && [ -n "$1" ] #if username was provided and it is not empty
then
    #get username
    username=$1
    #set log file name
    log_file="logs/$username-process-log-$date-$time.log"

    #write current date and time to the log file
    printf "Date: $date\nTime: $time\n" >> "$log_file"
    #line counter for the file; starts at 2 because of the date and time
    total_lines=$((2))
    
    for process in "${processes[@]}"
    do 
        #split each process info into an array
        IFS=$' ' read -r -a user_processes <<< "$process"
        if [ "$username" = "${user_processes[0]}" ]
        then
            printf "Process name: ${user_processes[10]}\n" >> "$log_file"
            printf "PID: ${user_processes[1]}\n" >> "$log_file"
            printf "CPU usage %%: ${user_processes[2]}\n" >> "$log_file"
            printf "Memory usage %%: ${user_processes[3]}\n" >> "$log_file"
            total_lines=$(($total_lines + 4)) #each process uses 4 lines
        fi
    done

    #display the user's log file content
    echo "Log file for user $username content:"
    cat "$log_file"
else
    #total line counter
    total_lines=$((0))
    for process in "${processes[@]}"
    do 
        #if username is not provided, default to current user
        username=$USER

        #split each process info into an array
        IFS=$' ' read -r -a user_processes <<< "$process"
        user="${user_processes[0]}"

        if [ "$user" != "USER" ] #skip the header row in the process list
        then
            log_file="logs/$user-process-log-$date-$time.log"
            #if the file is empty, write the date and time
            if [[ ! -s "$log_file" ]]
            then 
                printf "Date: $date\nTime: $time\n" >> "$log_file"
                total_lines=$(($total_lines + 2))
            fi
            printf "Process name: ${user_processes[10]}\n" >> "$log_file"
            printf "PID: ${user_processes[1]}\n" >> "$log_file"
            printf "CPU usage %%: ${user_processes[2]}\n" >> "$log_file"
            printf "Memory usage %%: ${user_processes[3]}\n" >> "$log_file"
            total_lines=$(($total_lines + 4)) #each process uses 4 lines
        fi
    done
fi

#print directory name, filenames, line count for each file and total line count
printf "\nDirectory name: logs\n"
echo "Log file name(s) and line count in each:"
IFS=$'\n' read -r -d '' -a filenames < <(find logs/* -type f)
for file in "${filenames[@]}"
do
    echo "Log file: $file"
    lines=$(wc -l < "$file") #get the line count in each file
    echo "Line count: $lines"
done
echo "Total line count: $total_lines"
#pause
read -p "Press enter to continue..."
#delete the logs directory and all (log) files inside it
rm -rf "logs"