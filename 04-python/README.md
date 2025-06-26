## 4 darbas - Python

Create python script for directory and/or file search. Script takes one argument - directory or file name or its part. Script should show results: <br>
if it is a file: 
* file name
* file path
* other file attributes like owner, permissions, create or access date (show 2 attributes only)

if it is a directory:
* content of directory (one level)
* directory path
* other file attributes like owner, permissions, create or access date (show 2 attributes only)

All searches should be saved in a log file.
Log file should have this format:
* call date
* script parameter (what file or dir name was provided)
* result that was show to user

All these results should be separated by delimiter (like ------ or ####).