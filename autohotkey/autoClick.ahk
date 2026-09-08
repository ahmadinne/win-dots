#Requires AutoHotkey v2.0
#SingleInstance Force

; Settings
targetWindow := "ahk_exe BongoWaifu.exe"
clickInterval := 50 ; Default delay between clicks in ms (50ms = ~20 CPS)
intervalStep := 50  ; Amount (ms) to adjust speed by per press
minInterval := 10   ; Speed cap: fastest interval (~100 CPS)
maxInterval := 1000 ; Speed cap: slowest interval (1 CPS)
isClicking := false

; F8: Toggle ON / OFF
F8:: {
    global isClicking
    isClicking := !isClicking
    
    if (isClicking) {
        SetTimer(AutoClick, clickInterval)
        ShowStatus("AutoClicker: ON")
    } else {
        SetTimer(AutoClick, 0)
        ShowStatus("AutoClicker: OFF")
    }
}

; F9: Speed UP (Decreases delay between clicks)
F9:: {
    global clickInterval
    if (clickInterval > minInterval) {
        clickInterval := Max(minInterval, clickInterval - intervalStep)
        UpdateInterval()
    } else {
        ShowStatus("Max Speed Reached: " . clickInterval . "ms")
    }
}

; F10: Slow DOWN (Increases delay between clicks)
F10:: {
    global clickInterval
    if (clickInterval < maxInterval) {
        clickInterval := Min(maxInterval, clickInterval + intervalStep)
        UpdateInterval()
    } else {
        ShowStatus("Min Speed Reached: " . clickInterval . "ms")
    }
}

UpdateInterval() {
    global isClicking, clickInterval
    if (isClicking) {
        SetTimer(AutoClick, clickInterval) ; Refresh active timer rate
    }
    cps := Round(1000 / clickInterval)
    ShowStatus("Interval: " . clickInterval . "ms (~" . cps . " CPS)")
}

ShowStatus(msg) {
    ToolTip(msg)
    SetTimer(() => ToolTip(), -1000)
}

AutoClick() {
    global targetWindow
    if WinExist(targetWindow) {
        ControlClick(, targetWindow)
    } else {
        SetTimer(AutoClick, 0)
        global isClicking := false
        ShowStatus("BongoWaifu.exe not found!")
    }
}
