## 1 darbas - Batch

Create batch script which reads all files of given extension from given directory and its sub directories into array or list, then iterate this array and form log file in the same directory. Log file should have this format:<br>
* current date 
* current time
* filename1
* filepath1
* filename2
* filepath2 ...

Then open this file with notepad.<br>

Parameters:
* %1 directory (default user home) <br>
* %2 file extension (default .bat) <br>

Use only windows commands, *.bat commands.<br>
After notepad opens, script should pause. <br>
After user continues script notepad windows should be closed, log deleted and then script finished. 