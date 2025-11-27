#Requires AutoHotkey v2.0
#SingleInstance Ignore
#UseHook

if !A_IsAdmin {
    try {
        Run('*RunAs "' A_ScriptFullPath '"')
    } catch {
        MsgBox "Ce script nécessite les privilèges administrateur !", "Erreur", 48
    }
    ExitApp
}

OnExit(AppExit)

global isBlocked := false

$^F9:: {
    global isBlocked
    if !isBlocked {
        RunWait('netsh advfirewall firewall add rule name="GTA Bloque Sauvegarde Braquage" dir=out action=block remoteip=192.81.241.171', , "Hide")
        ToolTip "Bloque Sauvegarde Braquage", 10, 10
    } else {
        RunWait('netsh advfirewall firewall delete rule name="GTA Bloque Sauvegarde Braquage"', , "Hide")
        Tooltip , 0, 0
    }
	isBlocked := !isBlocked
}

AppExit(*) {
    RunWait('netsh advfirewall firewall delete rule name="GTA Bloque Sauvegarde Braquage"', , "Hide")
}
