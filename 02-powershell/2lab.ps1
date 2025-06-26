#get date
$data = Get-Date -Format "yyyy-MM-dd"
#get time
$laikas = Get-Date -Format "HH-mm-ss"

#create directory for saving log files
$directory = '.\logFiles'
New-Item -Path $directory -ItemType Directory

#get all processes
$array = Get-Process -IncludeUserName

$username = $args[0]

#if username is provided
if (![string]::IsNullOrEmpty($username)) 
{
	#create log file name
	$logFile = "$directory\$username-process-log-$data-$laikas.txt"
	
	#write date and time
	Add-Content -Path $logFile -Value ($data), ($laikas)

	foreach ($element in $array)
	{	
		if ($element.UserName -ne $null)
		{
			#get username without the domain
			$User = $element.UserName.Substring($element.UserName.IndexOf("\") + 1)
			#write name, PID, cpu(s), pageable memory of each process
			if ("$username" -eq $User)
			{Add-Content -Path $logFile -Value "Process name: $($element.ProcessName)", "PID: $($element.Id)", "CPU(s): $($element.CPU)", "Pageable memory(K): $($element.PM)"}
		}
	}
	#open log file in notepad
	Start-Process notepad $logFile
}
else #if username is not provided
{
	#default to current user
	$username = [Environment]::UserName

	#create an array to store log file names
	$logFiles = @()
	foreach ($element in $array)
	{
		#for process with no user form it's own log file
		if ($element.UserName -eq $null) {$User = "NoUser"}
		#get username without the domain
		else {$User = $element.UserName.Substring($element.UserName.IndexOf("\") + 1)}
		#create log file name
		$logFile = "$directory\$User-process-log-$data-$laikas.txt"
		#check if log file for the user was already created
		$testfile = Test-Path $logfile
		#if log file was not created
		if ($testfile -ne $true) 
		{
			Add-Content -Path $logFile -Value ($data), ($laikas)
			$logFiles+=$logFile
		}
		#write name, PID, cpu(s), pageable memory of each process
		Add-Content -Path $logFile -Value "Process name: $($element.ProcessName)", "PID: $($element.Id)", "CPU(s): $($element.CPU)", "Pageable memory(K): $($element.PM)"

	}
	#open log files in notepad
	$logFiles | foreach-object {notepad $_}
}
#pause after notepad opens
pause

#close notepad
Stop-Process -Name notepad

#delete log files and their directory
Remove-Item $directory -Recurse