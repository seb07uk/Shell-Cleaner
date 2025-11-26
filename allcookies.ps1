Write-Host "Cleaning cookies in Microsoft Edge..."
Remove-Item "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cookies" -Force -ErrorAction SilentlyContinue

Write-Host "Cleaning cookies in Google Chrome..."
Remove-Item "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cookies" -Force -ErrorAction SilentlyContinue

Write-Host "Cleaning cookies in Firefox..."
$profile = Get-ChildItem "$env:APPDATA\Mozilla\Firefox\Profiles" | Select-Object -First 1
if ($profile) {
    Remove-Item (Join-Path $profile.FullName "cookies.sqlite") -Force -ErrorAction SilentlyContinue
}

Write-Host "Cleaning cookies in Internet Explorer / Edge Legacy..."
Remove-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Cookies\*" -Recurse -Force -ErrorAction SilentlyContinue
