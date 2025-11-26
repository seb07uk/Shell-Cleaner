@echo off
:: ================================================
echo Clean-SoftwareDistribution
echo Clears Windows Update download cache and shows notification
:: ================================================
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this script as Administrator.
    pause
    exit /b
)

echo Stopping Windows Update service...
net stop wuauserv /y >nul 2>&1

echo Cleaning Windows Update Download cache...
powershell -NoLogo -NoProfile -Command "Remove-Item -Path 'C:\Windows\SoftwareDistribution\Download\*' -Recurse -Force -ErrorAction SilentlyContinue"

echo Restarting Windows Update service...
net start wuauserv >nul 2>&1

:: Balloon notification
powershell -NoLogo -NoProfile -Command ^
  "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Windows Update download cache  Removed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::Info)}"

echo Windows Update cache cleanup completed successfully.
timeout /t 3 >nul
exit