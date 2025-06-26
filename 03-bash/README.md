## 3 darbas - Bash

Create bash script which reads all processes with users (who’s process) that runs on your computer into array or list, then iterate this array and form log files. For each user form separate file with it’s processes. Create directory and put all files in one directory.  After all logs are formed - output directory name, all log file names with line count in each, then output all files total line count. <br>
Log file should have this format (file name "$username-process-log-$date-$time.log"):
* current date 
* current time
* process name
* process pid
* process other parameters (take any 2)

1 parameter - username (default current user) - if user name is provided prepare log for this user only and print its content. <br>
Use only bash commands.  <br>
After all output script should pause. <br>
After user continues script should delete all files and directory and then script should finish. 