## 2 darbas - PowerShell

Create power-shell script which reads all processes with users (who’s process) that runs on your computer into array or list, then iterate this array and form log files. For each user form separate file with it’s processes. For process with no user form it’s own log file. Open all logs in notepad.<br>
Log file should have this format (file name "$username-process-log-$date-$time.txt"):
* current date 
* current time
* process name
* process pid
* process other parameters (take any 2)

Then open this file with notepad. <br>
1 parameter - username (default current user) - if user name is provided prepare log for this user only. <br>
Use only powershell commands. <br>
After notepad opens, script should pause.<br>
After user continues script notepad windows should be closed and then script finished. <br>