#Requires AutoHotKey v2.0

; Ctrl on hold, and Escape on click
; Capslock::Send "{Blind}{Ctrl DownR}"
; Capslock Up::{
; 	Send "{Blind}{Ctrl Up}"
; 	If (A_PriorKey = "Capslock") ; if capslock was pressed alone
; 		Send "{Esc}"
; }

; Grave on normal, Tilde on shift
; Capslock::`
; +Capslock::~

; Capslock to Ctrl
Capslock::Ctrl

; ---- GlazeWM Keybinds -----

; Programs
!t::Run "alacritty"
!e::Run "C:/Users/ahmadinne"
!b::Run "chrome"
!o::Run "obsidian"

; Utilities
!p::Send "#{PrintScreen}"
!s::Send "#+s"

; Windows management
!j::Run "glazewm command focus --direction left", , "Hide"
!k::Run "glazewm command focus --direction right", , "Hide"
!+j::Run "glazewm command move --direction left", , "Hide"
!+k::Run "glazewm command move --direction right", , "Hide"
!h::Run "glazewm command resize --width -2%", , "Hide"
!l::Run "glazewm command resize --width +2%", , "Hide"

; Pause Keybindings
!+p::Run "glazewm command wm-toggle-pause", , "Hide"
!Tab::Run "glazewm command wm-cycle-focus", , "Hide"

; Window States
!w::Run "glazewm command toggle-tiling", , "Hide"
!+w::Run "glazewm command toggle-floating --centered", , "Hide"
!+f::Run "glazewm command toggle-fullscreen", , "Hide"
!m::Run "glazewm command toggle-minimized", , "Hide"
!f::{
	if WinActive("Chrome") or WinActive("ahk_exe explorer.exe") {
		Send "{f11}"
	} else {
		Run "glazewm command toggle-fullscreen", , "Hide"
	}
}

; File Explorer typeshi
#HotIf WinActive("ahk_exe explorer.exe")
g::Send "{Home}"
+g::Send "{End}"
h::Send "!{Left}"
j::Send "{Down}"
k::Send "{Up}"
l::Send "{Enter}{Space}"
#HotIf
g::g
h::h
j::j
k::k
l::l

; Killer do killings
!q::Run "glazewm command close", , "Hide"
!+Del::Run "glazewm command wm-exit", , "Hide"

; Reload da guns!
!+r::Run "glazewm command wm-reload-config", , "Hide"
!r::Run "glazewm command wm-redraw", , "Hide"

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

    Case "tog" : ; bright(,"tog") toggles brightness through increments of 50 (0,50,100)
      Switch getBright(){
        Default:
          setBright(50)
        Case 50:
          setBright(100)
        Case 100:
          setBright(0)
        Case 0:
          setBright(50)      
      }
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
