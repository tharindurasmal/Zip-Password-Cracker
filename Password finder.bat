@echo off
:: Set the color for the banner (green text on black background)
color 0A

:: ASCII Banner for ZIP UNLOCKER
echo.
echo  RRRRR    AAAAA   SSSSS   H   H
echo  R   R   A     A  S       H   H
echo  RRRR    AAAAAAA  SSSSS   HHHHH
echo  R  R    A     A      S   H   H
echo  R   R   A     A  SSSSS   H   H

  
echo    Wellcome to Zip Unlocker
echo.
pause


:: Copy Unrar.exe to current directory
copy "C:\Program Files\WinRAR\Unrar.exe"
SET PASS=0
SET TMP=Temp
MD %TMP%

:RAR
cls
:: Add some color to the input prompt for better visibility
color 0A
echo ================================
echo        ZIP UNLOCKER
echo ================================
echo.
SET/P "NAME=File Name (with .ZIP extension): "
IF "%NAME%"=="" goto ProblemDetected
goto GPATH

:ProblemDetected
:: Change color to red for error messages
color 0C
echo You can't leave this blank.
pause
goto RAR

:GPATH
color 0A
SET/P "PATH=Enter Full Path (eg: C:\Users\Admin\Desktop): "
IF "%PATH%"=="" goto PERROR
goto NEXT

:PERROR
color 0C
echo You can't leave this blank.
pause
goto RAR

:NEXT
IF EXIST "%PATH%\%NAME%" GOTO SP
goto PATH

:PATH
cls
color 0C
echo File couldn't be found. Make sure you include the (.ZIP) extension at the end of the file's name.
pause
goto RAR

:SP
:: Add color to indicate progress
color 0E
echo.
echo Retrieving Password...
echo.
:START
title Processing...
SET /A PASS=%PASS%+1
UNRAR E -INUL -P%PASS% "%PATH%\%NAME%" "%TMP%"
IF /I %ERRORLEVEL% EQU 0 GOTO FINISH
GOTO START

:FINISH
RD %TMP% /Q /S
Del "Unrar.exe"
cls
title 1 Password Found
color 0A
echo.
echo ================================
echo         Password Found!
echo ================================
echo.
echo File = %NAME%
echo Stable Password= %PASS%
echo.
echo Press any key to exit.
pause>NUL
exit
