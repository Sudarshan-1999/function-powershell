$user = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$userPrincipal = New-Object System.Security.Principal.WindowsPrincipal($user)
$isLocalUser = $userPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
# $Localuser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$scriptPath = $PSScriptRoot + "\execution-policies.ps1"
Write-Host "System path of file: $scriptPath"
if($isLocalUser){
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File '$scriptPath'"
}
$get_policy= Get-ExecutionPolicy -List

Write-Output $get_policy
