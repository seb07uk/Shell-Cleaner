# ================================
# Clean-System.ps1
# Comprehensive Windows cleanup
# ================================

Write-Host ">>> Cleaning Recycle Bin..."
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Host ">>> Cleaning Temp folders..."
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ">>> Cleaning Windows Update cache..."
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service -Name wuauserv -ErrorAction SilentlyContinue

Write-Host ">>> Cleaning Prefetch..."
Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ">>> Cleaning system logs..."
Remove-Item -Path "C:\Windows\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\System32\LogFiles\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ">>> Cleaning crash dumps..."
Remove-Item -Path "C:\Windows\Minidump\*" -Recurse -Force -ErrorAction SilentlyContinue

# Balloon notification
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Information
$notify.Visible = $true
$notify.ShowBalloonTip(0, 'System cleanup completed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::Info)

Write-Host ">>> Cleanup finished successfully"
Start-Sleep -Seconds 3