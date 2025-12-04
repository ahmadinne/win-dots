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
!+j::Komorebic("move down")
!+k::Komorebic("move up")
!h::Komorebic("resize-axis horizontal decrease")
!l::Komorebic("resize-axis horizontal increase")

; Pause Keybindings
!+r::Komorebic("retile")
!^p::Komorebic("toggle-pause")

; Window States
!w::Komorebic("toggle-float")
!+f::Komorebic("toggle-monocle")
!m::Komorebic("minimize")
!f::{
	if WinActive("Helium") or WinActive("Firefox") or WinActive("Chrome") or WinActive("Minecraft") {
		Send "{f11}"
	} else {
		Komorebic("toggle-monocle")
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
