@echo off
set /p confirmAll="Do you want to clear ALL browser cookies? (Y/N): "
if /I "%confirmAll%"=="Y" (
    powershell -ExecutionPolicy Bypass -File "%~dp0allcookies.ps1"
    echo All cookies have been cleared.
	
timeout /t 3 >nul
exit
) else (
    echo Cleanup skipped.
)
timeout /t 3 >nul