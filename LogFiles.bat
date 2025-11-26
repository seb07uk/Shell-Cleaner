@echo off
:: ================================
echo Script: Clean Windows Log Files
:: Author: polsoft.ITS London
:: Description: Deletes Windows log files and shows a tray notification
:: ================================
echo.
echo Step 1: Delete all files in C:\Windows\Logs
powershell -Command "Remove-Item -Path 'C:\Windows\Logs\*' -Recurse -Force -ErrorAction SilentlyContinue"
echo Step 2: Delete all files in C:\Windows\System32\LogFiles
powershell -Command "Remove-Item -Path 'C:\Windows\System32\LogFiles\*' -Recurse -Force -ErrorAction SilentlyContinue"

powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Log files removed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"

timeout /t 3 >nul
exit