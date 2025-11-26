@echo off
REM ================================
REM Clean Firefox cookies and cache
REM ================================

powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
  "$firefoxProfile = Get-ChildItem \"$env:APPDATA\Mozilla\Firefox\Profiles\" | Select-Object -First 1; $cookiesPath = Join-Path $firefoxProfile.FullName 'cookies.sqlite'; $cachePath = Join-Path $firefoxProfile.FullName 'cache2'; Write-Host 'Deleting cookies...'; Remove-Item $cookiesPath -Force -ErrorAction SilentlyContinue; Write-Host 'Deleting cache...'; Remove-Item $cachePath -Recurse -Force -ErrorAction SilentlyContinue; Write-Host 'Firefox cleanup completed!'; Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Firefox has been cleaned up!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)"
timeout /t 2 >nul