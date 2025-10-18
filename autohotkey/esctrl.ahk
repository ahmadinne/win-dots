#Requires AutoHotKey v2.0
#UseHook
#InputLevel 1

SetKeyDelay(-1, -1)
SetCapsLockState("AlwaysOff")

; Escape = Grave on normal, Tilde on shift
Escape::`


; ---- The Monster ----
capsUsed := false

*CapsLock::
{
    global capsUsed
    capsUsed := false
    DllCall("keybd_event", "UInt",0x11, "UInt",0, "UInt",0, "UInt",0) 
}

*CapsLock up::
{
    global capsUsed
    DllCall("keybd_event", "UInt",0x11, "UInt",0, "UInt",2, "UInt",0) 
    if !capsUsed {
        DllCall("keybd_event", "UInt",0x1B, "UInt",0, "UInt",0, "UInt",0) 
        DllCall("keybd_event", "UInt",0x1B, "UInt",0, "UInt",2, "UInt",0)
    }
}

~*::
{
    global capsUsed
    if (GetKeyState("CapsLock", "P") && A_PriorKey != "CapsLock")
        capsUsed := true
}

; ---- Other Version which is slower ----

; Capslock to Ctrl
; Capslock::Ctrl

; *Capslock::
; {
; 	KeyWait("CapsLock", "T0.15")
; 	If GetKeyState("CapsLock", "P") {
; 		Send("{Ctrl down}")
; 		KeyWait("CapsLock")
; 		Send("{Ctrl up}")
; 	} Else {
; 		Send("{Escape}")
; 	}
; }

; isHold := false
; *CapsLock::
; {
; 	global isHold
; 	isHold := true
; 	SendInput("{Ctrl down}")
; }
; *CapsLock up::
; {
; 	global isHold
; 	SendInput("{Ctrl up}")
; 	if (A_PriorKey = "CapsLock") {
; 		if (A_TimeSincePriorHotkey < 150)
; 			SendInput("{Escape}")
; 	}
; }
