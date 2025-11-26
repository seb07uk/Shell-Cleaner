@echo off
set edgeProfile=%LOCALAPPDATA%\Microsoft\Edge\User Data\Default

echo Deleting cookies...
powershell -Command "Remove-Item '%edgeProfile%\Cookies' -Force -ErrorAction SilentlyContinue"

echo Deleting browsing history...
powershell -Command "Remove-Item '%edgeProfile%\History' -Force -ErrorAction SilentlyContinue"

echo Deleting cache...
powershell -Command "Remove-Item '%edgeProfile%\Cache\*' -Recurse -Force -ErrorAction SilentlyContinue"

echo Edge cleanup completed
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Microsoft Edge has been cleaned up!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
timeout /t 3 >nul