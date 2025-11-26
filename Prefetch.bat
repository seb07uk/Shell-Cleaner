@echo off
:: ================================================
echo Clean Prefetch
echo Description: Removes Windows Prefetch files using PowerShell
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

echo Cleaning Windows Prefetch folder...
powershell -NoLogo -NoProfile -Command "Remove-Item -Path 'C:\Windows\Prefetch\*' -Recurse -Force -ErrorAction SilentlyContinue"

echo Restarting Windows Update service...
net start wuauserv >nul 2>&1

:: Balloon notification
powershell -NoLogo -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Prefetch files removed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::Info)"

echo Prefetch Cleanup completed successfully.
timeout /t 3 >nul
exit