import sys
import os
import fnmatch
from datetime import datetime

#delimiter used to separate search results
delimiter="-------------------------------------------------------------------------"

#open (or create) the log file for appending
logFile = open('logFile.log', 'a')
#get current date
date = datetime.now()
#if argument was provided
if (len(sys.argv)==2):
    skaitliukas=0
    #get argument
    name = sys.argv[1]
    #iterate through all items in the current directory (and all subdirectories)
    for (root, dirs, files) in os.walk("."):
        #for every file
        for file in files:
            #check if the provided argument is part of the filename
            if fnmatch.fnmatch(file, f"*{name}*"):
                #get the filename, file path, owner and permissions
                filename = file 
                filepath = os.path.join(root, file)
                fileinfo = os.stat(filepath) 
                fileowner = fileinfo.st_uid 
                fileperm = fileinfo.st_mode 
                #if this is the first search result, log the search date and the provided argument
                if skaitliukas==0:
                    logFile.write(f"Search date: {date}\nScript parameter: {name}\nResults:\n")
                    print(f"Results:\n")
                info = f"Filename: " + filename + "\nFilepath: " + filepath + "\nFile owner: " + str(fileowner) + "\nFile permissions: " + str(fileperm)
                #print and log the search result
                print(f"{info}\n")
                logFile.write(f"\n{info}\n")
                skaitliukas+=1
        
        #for every directory
        for dir in dirs:
            #check if the provided argument is part of the directory name
            if fnmatch.fnmatch(dir, f"*{name}*"):
                #get the directory name, path, owner and permissions
                dirname = dir
                dirpath = os.path.join(root, dir)
                dirinfo = os.stat(dirpath)
                dirowner = dirinfo.st_uid
                dirperm = dirinfo.st_mode
                #get the content of the directory
                dircontent = os.listdir(dirpath)
                #join content into a string, separating items with ';'
                content= "; ".join(file for file in dircontent)
                #if this is the first search result, log the search date and the provided argument
                if skaitliukas==0:
                    logFile.write(f"Search date: {date}\nScript parameter: {name}\nResults:\n")
                    print(f"Results:\n")
                info = f"Directory name: " + dirname + "\nDirectory path: " + dirpath + "\nDirectory owner: " + str(dirowner) + "\nDirectory permissions: " + str(dirperm) + "\nDirectory content: " + content
                #print and log the search result
                print(f"{info}\n")
                logFile.write(f"\n{info}\n")
                skaitliukas+=1
    #once all of the search results are logged, append the delimiter
    logFile.write(f"{delimiter}\n")
#if the number of arguments provided is incorrect, print an error and exit
else: 
    print("Error. Script takes one argument.")
    exit(1)
