#Requires AutoHotKey v2.0
#SingleInstance Force

SetKeyDelay(-1, -1)
SetCapsLockState("AlwaysOff")


; ---- Basic ----
; ---- Only remap capslock to control, nothing else
*CapsLock::Ctrl


; ---- Normal ----
; - No bug or error with any combination
; - have a little delay before sending escape key
; - no delay for control when hold
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


; ---- The Monster ----
; - faster than the other version
; - but always send escape when releasing the capslock
; - can't use control + w in the terminal because of this
; #UseHook
; #InputLevel 1
; capsUsed := false
;
; *CapsLock::
; {
;     global capsUsed
;     capsUsed := false
;     DllCall("keybd_event", "UInt",0x11, "UInt",0, "UInt",0, "UInt",0) 
; }
;
; *CapsLock up::
; {
;     global capsUsed
;     DllCall("keybd_event", "UInt",0x11, "UInt",0, "UInt",2, "UInt",0) 
;     if !capsUsed {
; 		SendEvent("{Blind}{vk1B}")
; 		; below only works if you don't want to replace the original escape key with tilde or whatever is it
;         ; DllCall("keybd_event", "UInt",0x1B, "UInt",0, "UInt",0, "UInt",0) 
;         ; DllCall("keybd_event", "UInt",0x1B, "UInt",0, "UInt",2, "UInt",0)
;     }
; }
;
; ~*::
; {
;     global capsUsed
;     if (GetKeyState("CapsLock", "P") && A_PriorKey != "CapsLock")
;         capsUsed := true
; }


; ---- Very Slow version ----
; - has delay to everything, including when hold for control
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
