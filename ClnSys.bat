@echo off
set /p confirmAll="Do you want to Clear System? (Y/N): "
if /I "%confirmAll%"=="Y" (
    powershell -ExecutionPolicy Bypass -File "%~dp0ClnSys.ps1"
    echo System have been cleared.
	
timeout /t 3 >nul
exit
) else (
    echo Cleanup skipped.
)
timeout /t 3 >nul