@echo off
setlocal

pip install -r requirements.txt
if %errorlevel% neq 0 goto Error

::Replace with UPX installation path
pyinstaller -F -w -s -i editor.ico --upx-dir F:\Programs\UPX\ animed.pyw
if %errorlevel% neq 0 goto Error
xcopy /C /Y /R .\img .\dist\img\

timeout /t 3
exit /b 0

:Error
pause
