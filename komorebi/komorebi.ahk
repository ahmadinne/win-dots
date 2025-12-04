#Requires AutoHotKey v2.0
#SingleInstance Force

; ---- Komorebi Keybinds -----
Komorebic(cmd){
	RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

; Programs
!t::Run "wt"
!e::Run "$env:USERPROFILE"
; !;::Run "$env:USERPROFILE/scoop/apps/hunt-and-peck/current/hap.exe /hint"

; Windows management
!j::Komorebic("cycle-focus next")
!k::Komorebic("cycle-focus previous")
!Enter::Komorebic("promote-focus")
!+j::Komorebic("cycle-move next")
!+k::Komorebic("cycle-move previous")
!+Enter::Komorebic("promote")
!h::Komorebic("resize-axis horizontal decrease")
!l::Komorebic("resize-axis horizontal increase")

; Pause Keybindings
!r::Komorebic("retile")
!+r::{
	Komorebic("stop --ahk")
	Komorebic("start --ahk")
}
!^p::Komorebic("toggle-pause")

; Window States
!w::Komorebic("toggle-float")
; !+f::Komorebic("toggle-monocle")
!m::Komorebic("minimize")
!f::{
	if WinActive("Helium") or WinActive("Firefox") or WinActive("Chrome") or WinActive("Minecraft") {
		Send "{f11}"
	} else {
		Komorebic("toggle-maximize")
	}
}

; Killer do killings
!q::{
	check := WinExist("A")
	if !check
		return

	winClass := WinGetClass("ahk_id " check)
	if (winClass = "progman" || winClass = "WorkerW" || winClass = "shell_TrayWnd" || winClass = "buttery-taskbar")
		return

	if MsgBox("Confirm to Close?", "Warning", "YesNo") = "Yes"
		Komorebic("close")
}

; Workspaces
!1::Komorebic("focus-workspace 0")
!2::Komorebic("focus-workspace 1")
!3::Komorebic("focus-workspace 2")
!4::Komorebic("focus-workspace 3")
!5::Komorebic("focus-workspace 4")
!6::Komorebic("focus-workspace 5")
!7::Komorebic("focus-workspace 6")
!8::Komorebic("focus-workspace 7")

; Move windows across workspaces
!+1::Komorebic("move-to-workspace 0")
!+2::Komorebic("move-to-workspace 1")
!+3::Komorebic("move-to-workspace 2")
!+4::Komorebic("move-to-workspace 3")
!+5::Komorebic("move-to-workspace 4")
!+6::Komorebic("move-to-workspace 5")
!+7::Komorebic("move-to-workspace 6")
!+8::Komorebic("move-to-workspace 7")

; ---- Utilities ----

; Screenshot
!p::Send "#{PrintScreen}"
!+p::Send "#+s"

; Volume & Brightness
!,::Send "{Volume_Down}"
!.::Send "{Volume_Up}"
!+,::bright(5,"-")
!+.::bright(5,"+")

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
