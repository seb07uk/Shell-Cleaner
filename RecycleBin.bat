@echo off
:: BAT script to clear Recycle Bin via PowerShell
powershell.exe -NoLogo -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"

powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Recycle Bin done!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
exit