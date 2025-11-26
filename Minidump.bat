@echo off
:: ================================
echo Delete Minidump Files
:: ================================

echo Deleting files from Minidump folder...

echo Remove all files from C:\Windows\Minidump
powershell -NoLogo -NoProfile -Command "Remove-Item -Path 'C:\Windows\Minidump\*' -Recurse -Force -ErrorAction SilentlyContinue"

powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Crash Dumps files removed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::Info)}"

timeout /t 3 >nul
exit