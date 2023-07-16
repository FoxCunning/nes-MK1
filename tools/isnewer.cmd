@ECHO OFF
setlocal enabledelayedexpansion

set one=%1
set two=%2

for /f %%i in ('dir /b /o:d %one% %two%') do set newer=%%i

if "%newer%"=="%~n1%~x1" (
    ::echo returning 0
    endlocal & set %~2=0
    exit /b 0
) else (
    ::echo returning 1
    endlocal & set %~2=1
    exit /b 1
)