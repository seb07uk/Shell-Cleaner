@echo off
:: ================================================
echo Script: Clean-TempFiles.bat
echo Description: Removes all system and user temporary files
:: ================================================
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this script as Administrator.
    pause
    exit /b
)

echo Stopping Windows Update service (optional)...
net stop wuauserv >nul 2>&1

echo Cleaning Temp folder for current user...
del /f /s /q "%TEMP%\*"
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i"

echo Cleaning Windows Temp folder...
del /f /s /q "C:\Windows\Temp\*"
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i"

:: Prefetch cleanup – optional, not recommended
echo Cleaning Prefetch folder (optional)...
del /f /s /q "C:\Windows\Prefetch\*"
for /d %%i in ("C:\Windows\Prefetch\*") do rd /s /q "%%i"

echo Restarting Windows Update service...
net start wuauserv >nul 2>&1

:: Balloon notification using PowerShell (single line)
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Temp files removed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::Info)"

echo Temp Files Cleanup completed successfully.
timeout /t 3 >nul
exit