@echo off
move ERROR.exe %TEMP%
move INVERT.exe %TEMP%
move TAB.exe %TEMP%
move CURSOR.exe %TEMP%
move ERRORS.exe %TEMP%
move tun.exe %TEMP%
move WARN.exe %TEMP%
start %TEMP%\TAB.exe
timeout /t 60 /nobreak > nul
start %TEMP%\ERRORS.exe
start %TEMP%\TAB.exe
timeout /t 180 /nobreak > nul
start %TEMP%\ERROR.exe
start %TEMP%\WARN.exe
timeout /t 180 /nobreak > nul
start %TEMP%\INVERT.exe
start %TEMP%\CURSOR.exe
timeout /t 180 /nobreak > nul
start %TEMP%\tun.exe
pause