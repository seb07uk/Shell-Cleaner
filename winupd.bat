@echo off
set /p confirmAll="Do you want to Clear Windows Update? (Y/N): "
if /I "%confirmAll%"=="Y" (
    powershell -ExecutionPolicy Bypass -File "%~dp0winupd.ps1"
    echo Windows Update have been cleared.
	
timeout /t 3 >nul
exit
) else (
    echo Cleanup skipped.
)
timeout /t 3 >nul