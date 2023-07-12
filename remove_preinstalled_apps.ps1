# Title:        Remove default Software on Windows 10
# Description:  This script is semi-automatically removing the
#               default Applications installed on Windows.
# Created:      2020-07-17 - Vinalti
# Last Update:  2022-07-13 - Vinalti
# Author:       Vinalti
# Contributors: - ...


### PopUp Documentation: ###
# Button Types
#     0   OK button. 
#     1   OK and Cancel buttons. 
#     2   Abort, Retry, and Ignore buttons. 
#     3   Yes, No, and Cancel buttons. 
#     4   Yes and No buttons. 
#     5   Retry and Cancel buttons.    
# Icon Types 
#     16  "Stop Mark" icon. 
#     32  "Question Mark" icon. 
#     48  "Exclamation Mark" icon. 
#     64  "Information Mark" icon. 
# 
# Possible values for IntButton the return value:
#    1  OK button 
#    2  Cancel button and Red cross
#    3  Abort button 
#    4  Retry button 
#    5  Ignore button 
#    6  Yes button 
#    7  No button
### ### ###

function log($msg = "") {
    # Output message to stdout (can be edited for logging to a file)
    Write-Output $msg;
}

function promptContinue($message, $icon=32){
    # Prompt user to continue or abort. Exit Software if Abort is selected.
    $wshell = New-Object -ComObject Wscript.Shell -ErrorAction Inquire
    $r = $wshell.Popup($message, 0, "Continue ?", $icon + 1)
    if ( $r -ne 1 ) {
        log "[exit] User answered $r to prompt window."
        exit
    }
    log "[next] User want to coninue ($r)"
}

function infoPopup($message, $timeout=1, $icon=64){
    # Popup an information message for $timeout seconds.
    $wshell = New-Object -ComObject Wscript.Shell -ErrorAction Inquire
    return $wshell.Popup($message, $timeout, "Info", $icon + 0)
}


function RemoveSoftware($name, $displayName=$name){
    # Ask user if they wants to remove the application(s) matching a name if it is
    # installed and removable. $displayName is shown to the user. $name is used to
    # match the application(s) to remove.
    $wshell = New-Object -ComObject Wscript.Shell -ErrorAction Inquire
    $t = Get-AppxPackage *$name*
    $nonRemovable =  $t|Where-Object{$_.NonRemovable -eq $True}
    $t =  $t|Where-Object{$_.NonRemovable -eq $False}
    $r = 0
    $n = $t.length
    if ($nonRemovable.length -gt 0){
        $nr_name = ($nonRemovable.Name -join ', ')
        log "[NoRM] - Packages $nr_name cannot be removed."
        if ($n -eq 0 ){
            return ($nonRemovable.length * -1)
        }
    }
    if ( $n -eq 1 ){ 
        ## PROMPT TO REMOVE ONE PACKAGE ##
        $pkg = $t.name
        log "[one ] - Package $pkg installed."
        $r = $wshell.Popup("Uninstall $displayName : $pkg ?", 0, "Remove 1 Package", 32 + 4)

    } elseif ($n -gt 1){        
        ## PROMPT TO REMOVE MANY PACKAGES ##
        log "[many] - $n package for *$name*."
        $list = ($t.name -join ", ")
        $r = $wshell.Popup("Uninstall $displayName ($n): $list ?", 0, "Remove $n Package", 32 + 4)
    } else {
        log "[none] - Package $name not installed."
        return
    }

    if (($r -eq 6)){
        # REMOVE PACKAGE IF USER ACCEPTED ##
        $t | Remove-AppxPackage
        if ($? -eq $False){
            # If an error happened during deinstallation warn user
            log "[ERR ] Package $displayName not removed."
            $wshell.Popup("Impossible to remove $displayName.", 1, "Remove Software", 48)
            return 0
        }
        log "[DEL ] Package $displayName removed."
        # $wshell.Popup("$displayName Uninstalled.", 1, "Remove Software", 64)
        infoPopup("$displayName Uninstalled.")
        return $n
    }
    log "[skip] Skipping $displayName..."
    return
}

### TO BE REMOVED ###
promptContinue("Starting with Softwares you probably want to remove.")

RemoveSoftware "CandyCrushSaga" "CandyCrush" # CandyCrushSaga
RemoveSoftware "wallet" "Microsoft Pay"  # Microsoft Wallet (Microsoft Pay)
RemoveSoftware "skypeapp"       # App Get Skype
RemoveSoftware "officehub"      # App Get Office
RemoveSoftware "getstarted"     # Get Started or Tips
RemoveSoftware "solitaire"      # Microsoft Solitaire Collection
RemoveSoftware "bing"           # Money, News, Sports and Weather apps together
###  Single bing softwares (Skipped if bing is selected above) ###
RemoveSoftware "bingfinance"    # Money
RemoveSoftware "bingweather"    # Weather
RemoveSoftware "bingnews"       # News
RemoveSoftware "bingsports"     # Sports
## 
RemoveSoftware "onenote"        # OneNote
RemoveSoftware "sway"           # Sway
RemoveSoftware "oneconnect"     # Paid Wi-Fi & Cellular
RemoveSoftware "cortana"        # Cortana used to be Non-Removable but is removable on some version of Windows
RemoveSoftware "Microsoft.549981C3F5F10" "Cortana" # Alias for cortana on some version of Windows
# Windows 11 most preinstalled apps
RemoveSoftware "tiktok"
RemoveSoftware "twitter"
RemoveSoftware "instagram"
RemoveSoftware "BubbleWitchSaga"
RemoveSoftware "MarchOfEmpires"
RemoveSoftware "Disney"
RemoveSoftware "spotify"
RemoveSoftware "hulu"
RemoveSoftware "photoshop"
RemoveSoftware "picsart"
RemoveSoftware "Facebook"

### RECOMMENDED FOR REMOVAL ###
promptContinue("Continue with Software recommended for removal ?")

RemoveSoftware "phone"          # Phone and Phone Companion apps together
RemoveSoftware "feedback" "Feedback Hub" # Feedback Hub
RemoveSoftware "xbox"           # All Xbox Apps
RemoveSoftware "communicationsapps"  # Calendar and Mail apps together
RemoveSoftware "todos"
RemoveSoftware "maps"           # Maps
RemoveSoftware "messaging"      # Messaging and Skype Video apps together
RemoveSoftware "onedrive"       # OneDrive Connect
RemoveSoftware "connectivitystore"  # Microsoft Wi-Fi
RemoveSoftware "mspaint"        # Paint 3D
RemoveSoftware "people"         # People
RemoveSoftware "sticky"         # Sticky Notes
RemoveSoftware "3dbuilder"      # 3D Builder
RemoveSoftware "3d"             # View 3D
RemoveSoftware "soundrecorder"  # Voice Recorder
RemoveSoftware "holographic"    # Windows Holographic
RemoveSoftware "mixedReality" "Mixed Reality Portal" 
RemoveSoftware "Dolby"
RemoveSoftware "Teams"
# Windows 11 Specific
RemoveSoftware "Clipchamp" "Clipchamp Video Editor"
RemoveSoftware "GetHelp" # GetHelp Application
RemoveSoftware "GamingApp" # GetHelp Application

# Dell Laptop Specific
RemoveSoftware "partnerpromo"  "Dell PromoApp"
RemoveSoftware "dell*connect"  "Dell Connect Apps"
RemoveSoftware "dellCustomer"  "Dell Customer Connect"
RemoveSoftware "dellMobile"    "Dell Mobile Connect"
RemoveSoftware "myDell"        "My Dell"

### UNRECOMMENDED REMOVAL ###
promptContinue("Continue with Software not recommended for removal ?")

RemoveSoftware "calculator"     # Calculator
RemoveSoftware "camera"         # Camera
RemoveSoftware "alarms"         # Alarms & Clock
RemoveSoftware "appconnector"   # App Connector
RemoveSoftware "photos"         # Photos
# RemoveSoftware "zune"           # Groove Music and Movies & TV apps together
RemoveSoftware "zunemusic"      # Groove Music
RemoveSoftware "zunevideo"      # Movies & TV

promptContinue("Warning Last Applications are Windows Store and the AppInstaller, it cannot be undone, continue ?")
RemoveSoftware "windowsstore"   # Windows Store (Be very careful!)
RemoveSoftware "appinstaller"   # App Installer

infoPopup("Done", 0)
