@echo off
:: ================================================
echo Windows Disk Cleanup
echo Runs Windows Disk Cleanup (cleanmgr.exe) with AUTOCLEAN
:: ================================================
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this script as Administrator.
    pause
    exit /b
)

echo Running Disk Cleanup...
start /wait %SystemRoot%\System32\cleanmgr.exe /AUTOCLEAN

:: Balloon notification
powershell -NoLogo -NoProfile -Command ^
  "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Disk Cleanup completed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::Info)}"

echo Disk Cleanup completed successfully.
timeout /t 3 >nul
exit