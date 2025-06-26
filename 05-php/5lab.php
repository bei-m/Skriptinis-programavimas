#!/usr/bin/env php 

<?php
  #check if allowed number of arguments was provided
  if ($argc<=3)
  {
    #allowed file formats for the log file
    $fileFormats = ['txt', 'csv', 'html'];

    #get the file format, default to 'txt' if not provided; convert file format to lowercase to normalize input ('TXT' -> 'txt', etc)
    $failoTipas = empty($argv[1])? 'txt' : strtolower($argv[1]);
    #get the username, default to 'null' if not provided
    $username = empty($argv[2])? null : $argv[2];
    #remove all '.' from file format to normalize input ('.txt' -> 'txt', etc)
    $failoTipas = str_replace(".", "", $failoTipas);
    
    #check if the provided file format is allowed, if not, default to 'txt'
    if (!in_array($failoTipas, $fileFormats))
    {
        echo "Wrong file type provided. Defaulting to txt.\n";
        $failoTipas = 'txt';
    }
    
    #if username was provided
    if ($username)
    {
        #get processes only for the specified user (and header row)
        exec("ps aux | grep '^$username\|^USER'", $data);
        #set the log file name and extension based on provided arguments
        $logFileName = "$username-logFile.$failoTipas";
    }
    else
    {
        #get all processes
        exec("ps aux", $data);
        #set the log file name and extension based on provided arguments
        $logFileName = "logFile.$failoTipas";
    }
    #open (create) log file and open it for writing
    $logFile = fopen($logFileName, 'w');
    
    #format content based on the selected file format
    switch($failoTipas)
    {
        #format the data for csv format
        case 'csv':
            $duomenys="";
            foreach($data as $row)
            {
                #split the row into fields
                $process = preg_split('/\s+/', $row, 11);
                #join fields with semicolons (since commas are often used for decimal numbers)
                $duomenys .= join(";", $process);
                #separate rows with newlines
                $duomenys.="\n";
            }
            break;
        
        #format the data for html format
        case 'html':
            #extract the header row from the data
            $headerRow = array_shift($data);
            #start the html structure for the table
            $duomenys="<html>\n<head><title>Process list</title></head>\n<body>\n<table border='1'>\n";
            #wrap header row in <tr> and each field in <th>
            $duomenys.="<tr><th>\n" . join (" </th>\n<th> ", (preg_split('/\s+/', $headerRow, 11))). "</th>\n";
            #process non-header rows
            foreach($data as $row)
            {
                #split the row into fields
                $process = preg_split('/\s+/', $row, 11);
                #wrap row in <tr> and each field in <td>
                $duomenys.="<tr>\n";
                $duomenys .= "<td>" . join(" </td>\n<td> ", $process) . "</td>\n";
                $duomenys.="</tr>\n";
            }
            #end the html structure for the table
            $duomenys.="</table>\n</body>\n</html>";
            break;
        
        #format data for txt format
        default:
            $duomenys="";
            foreach($data as $row)
            {
                #split the row into fields
                $process = preg_split('/\s+/', $row, 11);
                #add padding to each field to ensure alignment
                foreach($process as $elem)
                {
                    $duomenys.=str_pad($elem, 24, " ", STR_PAD_RIGHT);
                }
                #separate rows with newlines 
                $duomenys.="\n";
            }
            break;
    }
    #write the formatted content to the log file
    fwrite($logFile, $duomenys);
    #give time to finish writing the file before telling the user
    sleep(1);
    #after the log file is formed, pause
    readline("You can view the log file in the current directory.\nPress Enter to delete log file...");
    #delete the log file
    unlink($logFileName);

  }
  #exit if too many arguments were provided
  else
  {
    echo "Too many arguments. Script takes up to two arguments.\n";
    exit(1);
  }
?>