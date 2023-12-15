# Windows remove preinstalled Applications
Script to remove default application in Windows 10/11

## How to Use
### OneLiner
Open a terminal with powershell and enter the following command :
```ps1
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser && Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Vinalti/Windows-Remove-Preinstalled-Apps/main/remove_preinstalled_apps.ps1" -OutFile ./_rpa.ps1 && ./_rpa.ps1 
```
_Reminder: As a good practice do not execute a script on your machine without double-checking its behavior. Make sure you understand what the above command is doing._

### From Explorer
1. Download the file `remove_preinstalled_apps.ps1`
2. Execute `remove_preinstalled_apps.ps1` by doing right-click > `Run with PowerShell`

### From Command Line
1. Download the file `remove_preinstalled_apps.ps1`
2. open a terminal with <kbd>shift</kbd> + Right Click* > `Open PowerShell window here` (`Open in Windows Terminal` for Windows 11)
3. `.\remove_preinstalled_apps.ps1`

*_You need to right click in an empty space on the explorer window, at the location of the downloaded file._

## Prerequisite
By default, you should be prevent from running unsigned scripts because of the "Execution Policy".
You can check the current Execution Policy with the following command :
```ps1
Get-ExecutionPolicy
# or
Get-ExecutionPolicy -Scope CurrentUser
```

If required you can change the Execution Policy, as Administrator with:
```ps1
# As admin:
Set-ExecutionPolicy Unrestricted
# or as a standard user:
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```
You can then restore the previous value with the command below. You can replace `AllSigned` by whatever value was retrieved with
`Get-ExecutionPolicy` before it was changed
```ps1
# As Admin :
Set-ExecutionPolicy AllSigned
# or as a standard user: 
Set-ExecutionPolicy AllSigned -Scope CurrentUser
```
