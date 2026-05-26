#Requires AutoHotKey v2.0
#SingleInstance Force

savedHwnd := 0
confirmOpen := false
confirmGui := 0
btnOrder := []
focusIndex := 1

; Killer do killings
!q:: {
    global savedHwnd, confirmOpen, confirmGui

    if confirmOpen
        return

    hwnd := WinExist("A")
    if !hwnd
        return

    class := WinGetClass("ahk_id " hwnd)
    if (class = "Progman"
     || class = "WorkerW"
     || class = "Shell_TrayWnd"
     || class = "buttery-taskbar")
        return

    savedHwnd := hwnd
    confirmOpen := true

    pid := WinGetPID("ahk_id " hwnd)
    title := WinGetTitle("ahk_id " hwnd)
    if (title = "")
        title := "(Untitled Window)"

    fullPath := WinGetProcessPath("ahk_id " hwnd)
    exeName := ""
    SplitPath(fullPath, &exeName)   ; extracts only filename (e.g. wt.exe)

    ; GUI
    confirmGui := Gui("+AlwaysOnTop +ToolWindow", "Confirm to Close?")
    confirmGui.backColor := "202020"
    confirmGui.SetFont("s10 cFFFFFF", "JetBrainsMono NF")

    confirmGui.AddText(, "Title: " title "`nExec : " exeName "`nPID  : " pid)
    confirmGui.AddText("cAAAAAA", "Press Y = Yes, N = No")

    btnYes := confirmGui.AddButton("xm h32", "Yes")
    btnNo := confirmGui.AddButton("x+10 h32 Default", "No")

    global btnOrder, focusIndex

    btnOrder := [btnYes, btnNo]
    focusIndex := 2

    btnYes.OnEvent("Click", (*) => CloseWindow())
    btnNo.OnEvent("Click", (*) => CloseDialog())

    confirmGui.Show("AutoSize Center")
    btnNo.Focus()

    margin := confirmGui.MarginX
    gap := 10

    confirmGui.GetClientPos(, , &cw, &ch)
    btnW := Floor((cw - margin*2 - gap) / 2)

    btnYes.Move(margin, , btnW)
    btnNo.Move(margin + btnW + gap, , btnW)

    ; WinGetPos(, , &w, &h, "ahk_id " confirmGui.Hwnd)
    ; rgn := DllCall("CreateRoundRectRgn", "int", 0, "int", 0, "int", w, "int", h, "int", 18, "int", 18, "ptr")
    ; DllCall("SetWindowRgn", "ptr", confirmGui.Hwnd, "ptr", rgn, "int", true)

    setTimer KeepFocus, 100

    EnableConfirmHotkeys()
}

KeepFocus() {
    global confirmGui
    if confirmGui && WinExist("ahk_id " confirmGui.Hwnd)
        WinActivate "ahk_id " confirmGui.Hwnd
}

EnableConfirmHotkeys() {
    global confirmGui
    HotIfWinActive("ahk_id " confirmGui.Hwnd)
    Hotkey "Escape", CloseDialog, "On"
    Hotkey "y", CloseWindow, "On"
    Hotkey "n", CloseDialog, "On"
    Hotkey "h", FocusLeft, "On"
    Hotkey "l", FocusRight, "On"
    HotIf
}

DisableConfirmHotkeys() {
    Hotkey "y", CloseWindow, "Off"
    Hotkey "n", CloseDialog, "Off"
    Hotkey "h", FocusLeft, "Off"
    Hotkey "l", FocusRight, "Off"
}

CloseWindow(*) {
    global savedHwnd
    if savedHwnd && WinExist("ahk_id " savedHwnd)
        WinClose "ahk_id " savedHwnd
    CloseDialog()
}

CloseDialog(*) {
    global confirmOpen, confirmGui

    setTimer KeepFocus, 0
    DisableConfirmHotkeys()

    if confirmGui && WinExist("ahk_id " confirmGui.Hwnd)
        confirmGui.Destroy()

    confirmGui := 0
    confirmOpen := false
}

FocusLeft(*) {
    global btnOrder, focusIndex
    focusIndex--
    if focusIndex < 1
        focusIndex := 1
        ; focusIndex := btnOrder.Length ;muter lagi ke kanan
    btnOrder[focusIndex].Focus()
}

FocusRight(*) {
    global btnOrder, focusIndex
    focusIndex++
    if focusIndex > btnOrder.Length
        focusIndex := 2
        ; focusIndex := 1 ;muter lagi ke kiri
    btnOrder[focusIndex].Focus()
}
