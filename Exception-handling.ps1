function hello {
   throw "Hi ! hello"   
}
try{ 
    hello 
}
catch {
    Write-Host -ForegroundColor Red "exception occurs in function"
}
finally {
    Write-Host -ForegroundColor green "Powershell Admin"
}
