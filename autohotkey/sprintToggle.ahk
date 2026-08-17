#Requires AutoHotkey v2.0
#SingleInstance Force

global sprintToggle := false

#HotIf IsMinecraftActive()

; Toggle Auto-Sprint mode on/off
*vk11:: {
    global sprintToggle := !sprintToggle
    
    if (sprintToggle) {
        ShowNotice("Toggle-Sprint: ON")
    } else {
        ShowNotice("Toggle-Sprint: OFF")
    }
    
    KeyWait "vk11"
}

; When Auto-Sprint is active, holding W presses Ctrl + W together
#HotIf IsMinecraftActive() && sprintToggle

$w:: {
    SendEvent "{Ctrl Down}{w Down}"
    
    KeyWait "w"                  ; Hold while physically holding W
    
    SendEvent "{w Up}{Ctrl Up}"  ; Release both cleanly when letting go
}

#HotIf

IsMinecraftActive() {
    if !WinActive("ahk_exe Minecraft.Windows.exe")
        return false
        
    title := WinGetTitle("A")
    return (title ~= "i)Minecraft")
}

ShowNotice(msg) {
	static bgGui := "", textGui := ""

	fontName := "Minecraft"
	fontSize := "s10"

	if IsObject(bgGui) {
		SetTimer HideNotice, 0
			bgGui.Destroy()
			textGui.Destroy()
	}

	CoordMode "Tooltip", "Window"
	WinGetPos ,, &winWidth, &winHeight, "A"

	dummy := Gui()
	dummy.SetFont(fontSize, fontName)
	txtCtrl := dummy.Add("Text",, msg)
	ControlGetPos ,, &w, &h, txtCtrl.Hwnd
	dummy.Destroy()

	boxW := w + 24
	boxH := h + 16
	pixelStep := 2 ; Size of the pixel steps (3px blocky steps)
	
	posX := winWidth - boxW - 15
	posY := winHeight - 45

	; Background
	bgGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
	bgGui.BackColor := "000000" ; TransColor canvas
	bgGui.SetFont("s1")

	; Top/Bottom notched pixel rows
	bgGui.Add("Progress", "X" pixelStep " Y0 W" (boxW - pixelStep*2) " H" pixelStep " Background101010 Disabled")
	bgGui.Add("Progress", "X" pixelStep " Y" (boxH - pixelStep) " W" (boxW - pixelStep*2) " H" pixelStep " Background101010 Disabled")
	bgGui.Add("Progress", "X0 Y" pixelStep " W" boxW " H" (boxH - pixelStep*2) " Background101010 Disabled")

	bgGui.Show("X" posX " Y" posY " W" boxW " H" boxH " NoActivate")
	WinSetTransColor("000000 190", bgGui)

	; Text
	textGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
	textGui.BackColor := "000000"

	textGui.SetFont(fontSize " cWhite", fontName)
	textGui.Add("Text", "Right X12 Y8", msg)
	textGui.Show("X" posX " Y" posY " W" boxW " H" boxH " NoActivate")

	WinSetTransColor("000000", textGui)

	SetTimer HideNotice, -1200

	HideNotice() {
		if IsObject(bgGui) {
			bgGui.Destroy()
				textGui.Destroy()
				bgGui := ""
				textGui := ""
		}
	}
}
