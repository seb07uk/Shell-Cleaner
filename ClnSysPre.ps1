# ================================
# Script: Clean-System-Premium-En.ps1
# Description: Full cleanup of Windows system + browsers + Disk Cleanup
# ================================

Write-Host ">>> Emptying Recycle Bin..."
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Host ">>> Cleaning Temp folders..."
Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue
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

# --- Browser cookies & cache ---
Write-Host ">>> Cleaning Microsoft Edge cookies/cache..."
Remove-Item "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cookies" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ">>> Cleaning Google Chrome cookies/cache..."
Remove-Item "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cookies" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ">>> Cleaning Firefox cookies/cache..."
$firefoxProfile = Get-ChildItem "$env:APPDATA\Mozilla\Firefox\Profiles" | Select-Object -First 1
if ($firefoxProfile) {
    Remove-Item (Join-Path $firefoxProfile.FullName "cookies.sqlite") -Force -ErrorAction SilentlyContinue
    Remove-Item (Join-Path $firefoxProfile.FullName "cache2") -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host ">>> Cleaning Internet Explorer / Legacy Edge cookies..."
Remove-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Cookies\*" -Recurse -Force -ErrorAction SilentlyContinue

# --- Disk Cleanup integration ---
Write-Host ">>> Running Disk Cleanup (cleanmgr.exe)..."
Start-Process -FilePath "$env:SystemRoot\System32\cleanmgr.exe" -ArgumentList "/AUTOCLEAN" -Wait

# --- Windows.old removal (if exists) ---
if (Test-Path "C:\Windows.old") {
    Write-Host ">>> Removing Windows.old folder..."
    Remove-Item "C:\Windows.old" -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host ">>> Premium cleanup completed successfully!"