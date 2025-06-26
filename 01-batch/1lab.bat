@echo off
setlocal EnableDelayedExpansion

:: get current date
set data=%DATE%
:: get current time
set laikas=%TIME%

:: get directory
set directory=%~1
:: set default directory to user home
if "%directory%"=="" set directory=%USERPROFILE%

:: get file extension
set ext=%~2
:: set default file extension to bat or remove '.'
if "%ext%"=="" (set ext=bat) else (set ext=!ext:.=!)

:: read all the files from given directory and file extension
set count=0
for /r %directory% %%f in (*.%ext%) do (
    set /a count+=1
    set failai[!count!].filename=%%~nxf
    set failai[!count!].filepath=%%f
)

:: form log file in the same directory
(
    echo %data%
    echo %laikas%
    for /l %%i in (1,1,%count%) do (
        echo !failai[%%i].filename!
        echo !failai[%%i].filepath!
    )
) > %directory%\log.txt

:: open log file with notepad
start notepad %directory%\log.txt 
pause

:: close notepad and delete log file
taskkill /f /im notepad.exe
del %directory%\log.txt

endlocal