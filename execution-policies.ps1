# $user = [System.Security.Principal.WindowsIdentity]::GetCurrent()
# $userPrincipal = New-Object System.Security.Principal.WindowsPrincipal($user)
# $isLocalUser = $userPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
$Localuser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

$scriptPath = $PSScriptRoot + "\execution-policies.ps1"
Write-Host "System path of file: $scriptPath"

$policy = Get-ExecutionPolicy CurrentUser
# $user = Get-LocalUser
Write-Host "`nThe Execution policy is $policy for users $Localuser"

# if(! $isLocalUser){
#     Write-Host "`nPlease RunAs with Administrator"
# }

# if($isLocalUser){
#     Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $scriptPath"
# }

$change_policy = Read-Host "`nDo you want to change policy (yes/no)"
if($change_policy -eq "no"){
    Write-Host "`nThe Existing Execution Policy is $policy"
    exit(1)
}
if($change_policy -eq "yes"){
    Write-Host "Policies are to change"
    # Write-Host "1. AllSigned"
    # Write-Host "2. Restricted"
    Write-Host "3. Unrestricted"
    Write-Host "4. RemoteSigned"
    # $policy_name = Read-Host "`nwhich Policy do you want to change "
$read_number = 1
 while($read_number){
    $policy_name = Read-Host "`nwhich Policy do you want to change "
    
    #     if($policy_name -eq 1){
    #     Set-ExecutionPolicy AllSigned  CurrentUser
    #     $policy = Get-ExecutionPolicy CurrentUser
    #     Write-Host "`nThe Current Execution Policy $policy"
    #     break
    # }elseif ($policy_name -eq 2) {
    #     Set-ExecutionPolicy Restricted CurrentUser
    #     $policy = Get-ExecutionPolicy CurrentUser
    #     Write-Host "`nThe Current Execution Policy $policy"
    #     break
    # }else
    if ($policy_name -eq 3){
        Set-ExecutionPolicy Unrestricted CurrentUser
        $policy = Get-ExecutionPolicy CurrentUser
        Write-Host "`nThe Current Execution Policy $policy"
        break
    }elseif($policy_name -eq 4){
        Set-ExecutionPolicy RemoteSigned CurrentUser
        $policy = Get-ExecutionPolicy CurrentUser
        Write-Host "`nThe Current Execution Policy $policy"
        break
    }
    else{
    Write-Host "`nWrong choosen !! please enter again "
    $attempt = 5
    if($read_number -eq $attempt ){
        Write-Host "Sorry can't get your expectation"
        exit(1)
    }
    $read_number+=1
# Read-Host "which Policy do you want to change "
}

}


}

