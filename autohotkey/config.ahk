#Requires AutoHotKey v2.0
#SingleInstance Force
#Include alt.ahk
#Include mcReso.ahk
#Include autoClick.ahk
; #Include sprintToggle.ahk
; #Include mousehide.ahk

; ---- GlazeWM Keybinds -----
userProfilePath := EnvGet("USERPROFILE")
glazewmc(cmd){
	RunWait(format("glazewm.exe command {}", cmd), , "Hide")
}

; Programs
!t::Run "wt"
!e::Run userProfilePath

; Utilities
!o::Send "#^v"				;Audio Output
!+o::Send "#p"				;Screen Output
; Screenshot whole screen
!p::{
	Send "#{PrintScreen}"
	Sleep 300
	TrayTip "Screenshot taken!", "File saved in Pictures/Screenshots", 1
}
; Screenshot active window
!+p::{
	Send "!{PrintScreen}"
	Sleep 300

	TargetDir := A_MyDocuments "\..\Pictures\Screenshots"
	if !DirExist(TargetDir)
		DirCreate(TargetDir)

	TimeStamp := FormatTime(, "yyyy-MM-dd_HH.mm.ss")
	FilePath := TargetDir "\screenshot_" Timestamp ".png"

	PowerShellCmd := 'powershell.exe -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; if ([System.Windows.Forms.Clipboard]::ContainsImage()) { [System.Drawing.Bitmap][System.Windows.Forms.Clipboard]::GetImage().Save(\"' FilePath '\", [System.Drawing.Imaging.ImageFormat]::Png) }"'
	Run(PowerShellCmd, , "Hide")
	Sleep 200
	TrayTip "Screenshot taken!", "File saved in Pictures/Screenshots", 1
}

; Windows management
!j::glazewmc("focus --direction down")
!k::glazewmc("focus --direction up")
!h::glazewmc("focus --direction left")
!l::glazewmc("focus --direction right")
!+j::glazewmc("move --direction up")
!+k::glazewmc("move --direction down")
!+h::glazewmc("move --direction left")
!+l::glazewmc("move --direction right")


; Reload and Exit
!+Del::glazewmc("wm-exit")
; Reload da guns!
!+r::glazewmc("wm-reload-config")
!r::glazewmc("wm-redraw")

; Volume & Brightness
!m::Send "{Volume_Mute}"
!,::Send "{Volume_Down}"
!.::Send "{Volume_Up}"
!+,::bright(5,"-")
!+.::bright(5,"+")

; Pause Keybindings
!^p::glazewmc("wm-toggle-pause")
; !Tab::glazewmc("wm-cycle-focus")

; Window States
!w::glazewmc("toggle-tiling")
!+w::glazewmc("toggle-floating --centered")
!+f::glazewmc("toggle-fullscreen")
!+m::glazewmc("toggle-minimized")
!f::Send "{f11}"

!q::{
    check := WinExist("A")
	if !check
		return

	title := WinGetTitle("ahk_id " check)
	if (title = "")
		title := "Untitled"

	winClass := WinGetClass("ahk_id " check)
	if (winClass = "progman" || winClass = "WorkerW" || winClass = "shell_TrayWnd" || winClass = "buttery-taskbar")
		return

	msgTitle := "Warning - Close Window"
	hasBeenActive := false

	setTimer(CheckFocus, 50)
	result := MsgBox("Confirm to Close " title "?", msgTitle, "YesNoCancel")
	setTimer(CheckFocus, 0)

	if (result = "Yes")
		glazewmc("close")
	
	CheckFocus(){
		targetWindow := msgTitle " ahk_class #32770"

		if !WinExist(targetWindow)
			return

		if WinActive(targetWindow)
			hasBeenActive := true
		else if (hasBeenActive) {
			WinClose(targetWindow)
			SetTimer(CheckFocus, 0)
		}
	}
}

!+q::{
	hwnd := WinExist("A")
	if !hwnd
		return

	title := WinGetTitle("ahk_id " hwnd)
	winClass := WinGetClass("ahk_id " hwnd)
	pid := WinGetPID("ahk_id " hwnd)
	fullPath := WinGetProcessPath("ahk_id " hwnd)
	exeName := ""
	SplitPath(fullPath, &exeName)

    MsgBox(
		"Title: " title "`nPID  : " pid  "`nClass : " winClass "`nExec : " exeName "`nPath : " fullPath,
		"Active window Informations",
		"OK"
	)
}

; Workspace Management
!1::glazewmc("focus --workspace a1")
!2::glazewmc("focus --workspace a2")
!3::glazewmc("focus --workspace a3")
!4::glazewmc("focus --workspace a4")
!5::glazewmc("focus --workspace a5")
!6::glazewmc("focus --workspace a6")
!7::glazewmc("focus --workspace a7")
!8::glazewmc("focus --workspace a8")
!9::glazewmc("focus --workspace a9")
!0::glazewmc("focus --workspace a10")

#1::glazewmc("focus --workspace b1")
#2::glazewmc("focus --workspace b2")
#3::glazewmc("focus --workspace b3")
#4::glazewmc("focus --workspace b4")
#5::glazewmc("focus --workspace b5")
#6::glazewmc("focus --workspace b6")
#7::glazewmc("focus --workspace b7")
#8::glazewmc("focus --workspace b8")
#9::glazewmc("focus --workspace b9")
#0::glazewmc("focus --workspace b10")

; Moving Window to Worskpace
!+1::glazewmc("move --workspace a1") glazewmc("focus --workspace a1")
!+2::glazewmc("move --workspace a2") glazewmc("focus --workspace a2")
!+3::glazewmc("move --workspace a3") glazewmc("focus --workspace a3")
!+4::glazewmc("move --workspace a4") glazewmc("focus --workspace a4")
!+5::glazewmc("move --workspace a5") glazewmc("focus --workspace a5")
!+6::glazewmc("move --workspace a6") glazewmc("focus --workspace a6")
!+7::glazewmc("move --workspace a7") glazewmc("focus --workspace a7")
!+8::glazewmc("move --workspace a8") glazewmc("focus --workspace a8")
!+9::glazewmc("move --workspace a9") glazewmc("focus --workspace a9")
!+0::glazewmc("move --workspace a10") glazewmc("focus --workspace a10")

#+1::glazewmc("move --workspace b1") glazewmc("focus --workspace b1")
#+2::glazewmc("move --workspace b2") glazewmc("focus --workspace b2")
#+3::glazewmc("move --workspace b3") glazewmc("focus --workspace b3")
#+4::glazewmc("move --workspace b4") glazewmc("focus --workspace b4")
#+5::glazewmc("move --workspace b5") glazewmc("focus --workspace b5")
#+6::glazewmc("move --workspace b6") glazewmc("focus --workspace b6")
#+7::glazewmc("move --workspace b7") glazewmc("focus --workspace b7")
#+8::glazewmc("move --workspace b8") glazewmc("focus --workspace b8")
#+9::glazewmc("move --workspace b9") glazewmc("focus --workspace b9")
#+0::glazewmc("move --workspace b10") glazewmc("focus --workspace b10")

; Functions (Do Not Delete)
bright(inputNum:=0,option:=""){
  Switch option {
    Default: ; bright(70) sets brightess to 70
      setBright(inputNum)

    Case "+" : ; bright(10,"+") increases brightess by 10
      setBright(getBright()+inputNum)

    Case "-" : ; bright(10,"-") decreases brightess by 10
      setBright(getBright()-inputNum)
  }
}
setBright(inputB){
  targetB:=(inputB<100)?(inputB):(100)  ; Maximum of 100
  targetB:=(inputB>0)?(inputB):(0)      ; Minimum of 0
  For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightnessMethods" )
    property.WmisetBrightness( 1, targetB )
  Tooltip(getBright())
  SetTimer( ()=>ToolTip(), -1000)
}
getBright(){
	For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightness" )
    return property.CurrentBrightness
}
