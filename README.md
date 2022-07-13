# Windows remove preinstalled Applications
Script to remove default application in Windows 10/11

## How to Use
### From Explorer
1. Download the file `remove_preinstalled_apps.ps1`
2. Execute `remove_preinstalled_apps.ps1` by doing right-click > `Run with PowerShell`

### From Command Line
1. Download the file `remove_preinstalled_apps.ps1`
2. open a terminal with <kbd>shift</kbd> + Right Click* > `Open PowerShell window here` (`Open in Windows Terminal` for Windows 11)
3. `.\remove_preinstalled_apps.ps1`

*_You need to right click in an empty space on the explorer window, at the location of the downloaded file._

## Prerequisite
Usually no prerequisite are necessary.  
However, in certain cases you can be prevent from running it by the Execution Policy.
In which case you need to run the following command in an `Administrator` Powershell:
```ps
Set-ExecutionPolicy RemoteSigned
```
You can then restore the previous value with
```ps
Set-ExecutionPolicy Signed
```
