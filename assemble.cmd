@ECHO OFF

setlocal enabledelayedexpansion
set path=%path%;"%~dp0\tools"
::cls

set emulator=""
if exist "..\..\..\Mesen\Mesen.exe" (
	set emulator="..\..\..\Mesen\Mesen.exe"
)
if exist "..\..\..\..\Mesen\Mesen.exe" (
	set emulator="..\..\..\..\Mesen\Mesen.exe"
)

if exist "out\MK1.nes" (copy "out\MK1.nes" "out\MK1.backup.nes" >nul)

if not exist out\ (mkdir out)

:Assemble

echo.
echo [1;33mAssembling Mortal Kombat...[0m
echo.

:: TODO Check if object file is already up to date
echo [1;93m
for %%f in (bank_*.asm) do (
	REM echo | set /p d="[1;39m%%f[0m... "
	<nul set /p=[%%~nf] 
	
	REM call :Compare %%f out\%%~nf.o
	REM echo | set /p d="!newsrc! - !errorlevel!"

	REM del out\%%~nf.o >nul 2>&1
	ca65 -U -l %%~nf.lst -g %%f -o out\%%~nf.o
	if !errorlevel! neq 0 goto Error
	REM echo | set /p d="... "
)

:: Make sure all object files exist
for %%o in (0 1 2 3 4 5t 5b 6 7 8 9 A B C D E F) do (
	if not exist out\bank_0%%o.o (
		echo.
		echo out\bank_%%o.o not found!
		echo.
		goto Error
	)
)

echo ... [1;32mdone[0m
echo [1;33m
<nul set /p=Linking ... 
ld65 -C ld65.cfg -o out\MK1.bin --dbgfile _debug.txt ^
	out\bank_00.o ^
	out\bank_01.o ^
	out\bank_02.o ^
	out\bank_03.o ^
	out\bank_04.o ^
	out\bank_05t.o ^
	out\bank_05b.o ^
	out\bank_06.o ^
	out\bank_07.o ^
	out\bank_08.o ^
	out\bank_09.o ^
	out\bank_0A.o ^
	out\bank_0B.o ^
	out\bank_0C.o ^
	out\bank_0D.o ^
	out\bank_0E.o ^
	out\bank_0F.o

if %errorlevel% neq 0 goto Error
echo [1;32mdone[0m

copy /B bin\header.bin + out\MK1.bin + bin\chr.bin "out\MK1.nes" >nul
copy /A bank_*.lst _listing.txt >nul

echo [1;97m
lua54 dbg2mlb.lua

:CleanUp
del *.lst >nul 2>&1

echo [0m
if "%emulator%" equ "" goto End
if not exist "%emulator%" goto End

::set /p ask=Launch emulator (Y/[N])? 
::if /i "%ask%" neq "Y" goto End
choice /C YN /M "Launch emulator"
if "%errorlevel%" neq "1" goto End

start "" %emulator% "out\MK1.nes"
exit /b

:End
timeout /t 5
exit /b

:Error
echo.
echo ... [1;34mErrors found, think harder![0m
echo.
::pause
del *.lst >nul 2>&1
choice /C YN /M "Try again"
if "%errorlevel%"=="1" goto Assemble
exit /b 1


:Compare
:: echo Comparing %~1 to %~2 ...

:: Source file
for %%i in (%~1) do set srcdate=%%~ti
:: Object file
for %%i in (%~2) do set objdate=%%~ti

if "%srcdate%"=="%objdate%" goto CompareEnd

for /f %%i in ('dir /B /O:D %~1 %~2') do set newer=%%i
if %newer%==%~1 goto NewSource

:CompareEnd
:: echo Object file is up to date.
set newsrc=0
exit /b 0

:NewSource
:: echo Source file modified.
set newsrc=1
exit /b 1