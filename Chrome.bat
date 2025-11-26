@echo off
echo Delete Chrome Cookies file
powershell -NoLogo -NoProfile -Command ^
"Remove-Item \"$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cookies\" -Force -ErrorAction SilentlyContinue"

powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Chrome Cookies Removed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
timeout /t 3 >nul