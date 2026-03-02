#Requires AutoHotkey v2.0+
Persistent
#SingleInstance

global vimMode := "insert" ; Default mode is Insert

; Monitor if Notepad is active
#HotIf WinActive("ahk_exe explorer.exe")

; Reload the script with a binding
~!r::Reload

; Switch to Normal mode with Esc
~Esc::{    
  global vimMode
    vimMode := "normal"
    Tooltip vimMode, 1740, 966
    SetTimer( ()=>Tooltip(), -1000)
}

~Enter::{
  global vimMode
    if (vimMode == "insert") {
      Send "{Enter}"
      vimMode := "normal"
    }
}

; Switch to Insert mode with 'i'
i::{
  global vimMode
    if (vimMode == "normal") {
      vimMode := "insert"
      Tooltip vimMode, 1740, 966
      SetTimer( ()=>Tooltip(), -1000)
    } else {
      SendText "i" ; Let 'i' work as usual in Insert mode
    }
}   

; Implement Vim keybindings in Normal mode
; Move cursor down and up
j::{    
  global vimMode
    if (vimMode == "normal") {
      Send "{Down}"
    } else if (vimMode == "select") {
      Send "^{Down}"
    } else {
      SendText "j"
    }
}

k::{    
  global vimMode
    if (vimMode == "normal") {
      Send "{Up}"
    } else if (vimMode == "select") {
      Send "^{Up}"
    } else {
      SendText "k"
    }
}

h::{
  global vimMode
    if (vimMode == "normal") {
      Send "!{Up}"
    } else {
      SendText "h"
    }
}

l::{
  global vimMode
    if (vimMode == "normal") {
      Send "{Enter}"
      if WinWait(,, 0.5) {
        Send "^{Space}"
      }
    } else {
      SendText "l"
    }
}

g::{
  global vimMode
  if (vimMode != "insert") {
    Send "{Home}"
  } else {
    SendText "g"
  }
}

+g::{
  global vimMode
  if (vimMode != "insert") {
    Send "{End}"
  } else {
    SendText "G"
  }
}

^e::{
  global vimMode
  if (vimMode == "normal") {
    Send "!d"
    Send "{Tab}{Tab}{Tab}{Tab}"
  }
}

Space::{
  global vimMode
    if (vimMode == "normal") {
      Send "^{Down}"
      vimMode := "select"
      Tooltip vimMode, 1740, 966
      SetTimer( ()=>Tooltip(), -1000)
    } else if (vimMode == "select") {
      Send "^{Space}"
      Send "^{Down}"
    } else {
      Send "{Space}"
    }
}

; focus the file search
/::{
  global vimMode
    if (vimMode == "normal") {
      vimMode := "insert"
      Send "^f"
    } else {
      Send "/"
    }
}

; Cut files
x::{
  global vimMode
    if (vimMode != "insert") {
      Send "^x"
    } else {
      SendText "x"
    }
}

; Yank / Copy files
y::{
  global vimMode
    if (vimMode != "insert") {
      Send "^c" ; Copy to clipboard
    } else {
      Send "y"
    }
}

; Paste files
p::{
  global vimMode
    if (vimMode = "normal") {
      Sleep 100
        Send "^v" 
    } else {
      Send "p"
    }
}

; Delete and Permanently delete selected files
d::{
  global vimMode
    if (vimMode != "insert") {
      Send "{Del}"
    } else {
      Send "d"
    }
}

+d::{
  global vimMode
    if (vimMode != "insert") {
      Send "+{Del}" 
    } else {
      send "D"
    }
}

; Create new file and folder
a::{
  global vimMode
    if (vimMode == "normal") {
      Click("Right")
        Send "wt"
        Send "^a"
        vimMode := "insert"
    } else {
      Send "a"
    }
}

+a::{
  global vimMode
    if (vimMode == "normal") {
      Send "^+n"
      Send "^a"
      vimMode := "insert"
    } else {
      Send "A"
    }
}

#HotIf ; End of context-sensitive hotkeys
