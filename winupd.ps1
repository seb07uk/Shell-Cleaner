# ================================
# Clean-WindowsUpdate.ps1
# Clears Windows Update cache
# ================================

Write-Host ">>> Stopping Windows Update service..."
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue

Write-Host ">>> Removing files from SoftwareDistribution\Download..."
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ">>> Removing files from Catroot2..."
Remove-Item -Path "C:\Windows\System32\catroot2\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ">>> Restarting Windows Update service..."
Start-Service -Name wuauserv -ErrorAction SilentlyContinue

# Balloon notification
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Information
$notify.Visible = $true
$notify.ShowBalloonTip(0, 'Windows Update cleanup completed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::Info)

Write-Host ">>> Cleanup finished successfully"
Start-Sleep -Seconds 3