#Requires AutoHotkey v2.0
#SingleInstance Force
InstallMouseHook()  ; <-- Changed from #InstallMouseHook to a function

SystemCursor("I")

SetTimer(CheckIdle, 250)

CheckIdle() {
    if A_TimeIdlePhysical >= 5000
        SystemCursor(False)
    else
        SystemCursor(True)
}

SystemCursor(OnOff := 1) {
    ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
    
    Static sys_state := ""   
    Static b := []           
    Static h := []           
    Static c := [32512, 32513, 32514, 32515, 32516, 32642, 32643, 32644, 32645, 32646, 32648, 32649, 32650]
    
    OnOffStr := String(OnOff) 

    If (OnOffStr = "Init" || OnOffStr = "I" || sys_state = "") {
        sys_state := "h"
        
        AndMask := Buffer(128, 0xFF)
        XorMask := Buffer(128, 0)
        
        For index, cursor in c {
            h_cursor := DllCall("LoadCursor", "Ptr", 0, "Ptr", cursor, "Ptr")
            h.Push(DllCall("CopyImage", "Ptr", h_cursor, "UInt", 2, "Int", 0, "Int", 0, "UInt", 0, "Ptr"))
            b.Push(DllCall("CreateCursor", "Ptr", 0, "Int", 0, "Int", 0, "Int", 32, "Int", 32, "Ptr", AndMask.Ptr, "Ptr", XorMask.Ptr, "Ptr"))
        }
    }
    
    isOff := (OnOffStr = "0" || OnOffStr = "Off")
    isToggle := (OnOffStr = "-1" || OnOffStr = "Toggle" || OnOffStr = "T")
    
    sys_state := (isOff || (sys_state = "h" && isToggle)) ? "b" : "h"
    
    For index, cursor in c {
        handle := (sys_state = "b") ? b[index] : h[index]
        h_cursor := DllCall("CopyImage", "Ptr", handle, "UInt", 2, "Int", 0, "Int", 0, "UInt", 0, "Ptr")
        DllCall("SetSystemCursor", "Ptr", h_cursor, "UInt", cursor)
    }
}
