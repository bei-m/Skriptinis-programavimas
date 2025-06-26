## 5 darbas - PHP

Create php script to get processes. Script takes two arguments - file format and username. Script should: <br>
* take all processes of all users or for selected user if second argument is provided
* form log as a table: first row column names and all other processes information
* take as many process information as possible

Default file format is txt, but html or csv could be set - prepare log file for selected file type. <br>
Script should pause after log was formed and after key press log should be deleted and script finished. <br>
Script should run as command line script like “script.php”, but not as “php script.php” or through interpreter or web server.