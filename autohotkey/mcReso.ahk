#Requires AutoHotkey v2.0
#SingleInstance Force

targetApp := "ahk_exe Minecraft.Windows.exe"
targetWidth := 1280
targetHeight := 720
hasResized := false

; Checks focused window state every 250ms
SetTimer(CheckFocus, 250)

CheckFocus() {
    global hasResized
    if WinActive(targetApp) {
        if !hasResized {
            ; Removes title bar (WS_CAPTION 0xC00000) and window frame borders (WS_THICKFRAME 0x400000)
            WinSetStyle("-0xC40000", targetApp)

            ; Centers the 1280x720 window on your display
            ; centerX := (A_ScreenWidth - targetWidth) / 2
            ; centerY := (A_ScreenHeight - targetHeight) / 2

            ; Moves and resizes the borderless window
            ; WinMove(centerX, centerY, targetWidth, targetHeight, targetApp)
            ; hasResized := true
        }
    } else {
        ; Resets flag when switching away so it re-applies if window state changes
        hasResized := false
    }
}


; targetApp := "ahk_exe Minecraft.Windows.exe"
; isStateChanged := false
; origSpeed := 10
;
; SetTimer(CheckFocus, 250)
;
; CheckFocus() {
;     global isStateChanged, origSpeed
;     if WinActive(targetApp) {
;         if !isStateChanged {
;             ; Query and store your current Windows pointer speed (1-20 scale)
;             DllCall("SystemParametersInfo", "UInt", 0x70, "UInt", 0, "UInt*", &currentSpeed := 0, "UInt", 0)
;             origSpeed := currentSpeed
;
;             ; Change display resolution to 1280x720
;             SetDisplayResolution(1280, 720)
;
;             ; Lower mouse speed by 2 (1 full notch left in Legacy Control Panel)
;             newSpeed := Max(1, origSpeed - 2)
;             SetMouseSpeed(newSpeed)
;
;             isStateChanged := true
;         }
;     } else {
;         if isStateChanged {
;             ; Restore resolution and mouse speed when switching away
;             RestoreDisplayResolution()
;             SetMouseSpeed(origSpeed)
;             isStateChanged := false
;         }
;     }
; }
;
; SetMouseSpeed(speed) {
;     ; SPI_SETMOUSESPEED = 0x71
;     DllCall("SystemParametersInfo", "UInt", 0x71, "UInt", 0, "Ptr", speed, "UInt", 0)
; }
;
; SetDisplayResolution(w, h) {
;     DEVMODE := Buffer(220, 0)
;     NumPut("UShort", 220, DEVMODE, 68)        ; dmSize
;     NumPut("UInt", 0x180000, DEVMODE, 72)       ; dmFields (DM_PELSWIDTH | DM_PELSHEIGHT)
;     NumPut("UInt", w, DEVMODE, 172)            ; dmPelsWidth
;     NumPut("UInt", h, DEVMODE, 176)            ; dmPelsHeight
;     DllCall("ChangeDisplaySettingsW", "Ptr", DEVMODE, "UInt", 0)
; }
;
; RestoreDisplayResolution() {
;     DllCall("ChangeDisplaySettingsW", "Ptr", 0, "UInt", 0)
; }
;
; ; Guarantees display resolution and cursor speed are restored if script closes
; OnExit(ExitHandler)
;
; ExitHandler(exitReason, exitCode) {
;     global origSpeed, isStateChanged
;     if isStateChanged {
;         RestoreDisplayResolution()
;         SetMouseSpeed(origSpeed)
;     }
; }
