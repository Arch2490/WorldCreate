#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force

global seeds := []       ; Array to hold seeds
global currentIndex := 1 ; Track current seed index
global mcVersion := "1.21+" ; Default version

; GUI setup
Gui, Font, s12, Segoe UI
Gui, Add, Text,, Select Minecraft Version:
Gui, Add, DropDownList, vMCVersionChoice w220, JE 1.21+|JE ≤1.20
Gui, Add, Text,, Paste Seeds (one per line):
Gui, Add, Edit, vSeedBox w460 r12
Gui, Add, Button, gLoadSeeds w140, Load Seeds
Gui, Add, Text, vStatus w460, No seeds loaded.
Gui, Add, Text,, Hotkeys:
Gui, Add, Text,, • Press F6 to load next world
Gui, Add, Text,, • Press F7 to exit world
Gui, Show,, Minecraft World Loader
return

GuiClose:
ExitApp

; Load Seeds
LoadSeeds:
Gui, Submit, NoHide
seeds := []            ; reset
currentIndex := 1
Loop, Parse, SeedBox, `n, `r
{
    line := Trim(A_LoopField)
    if (line != "")
        seeds.Push(line)
}
if (seeds.Length() > 0)
    GuiControl,, Status, % "Loaded " seeds.Length() " seeds."
else
    GuiControl,, Status, No seeds loaded.
return

; Create World hotkey (F6)
F6::	; you can change this hotkey to whatevfer you want if you want to
if (seeds.Length() = 0) {
    MsgBox, 48, Error, Please load seeds first!
    return
}
if (currentIndex > seeds.Length()) {
    MsgBox, 64, Done, All seeds have been checked.
    return
}

; Copy next seed to clipboard
Clipboard := seeds[currentIndex]
ClipWait, 0.5

; Run macro depending on version
Gui, Submit, NoHide
if (MCVersionChoice = "JE 1.21+")
    Gosub, World_121
else
    Gosub, World_120

currentIndex++
return

; Leave world hotkey (F7)
F7:: 	; you can also change this one too
Send {esc}
Sleep 75
MouseMove, 960, 625, 0
Click
return


; JE >1.21 Create World Script
World_121:
MouseMove, 960, 420, 0
Click
Sleep 200
MouseMove, 1198, 928, 0
Click
Sleep 1000
Send ^a
Sleep 80
Send ^v
Sleep 200
MouseMove, 967, 317, 0
Sleep 200
Click 2
Sleep 200
MouseMove, 860, 43, 0
Click
Sleep 200
MouseMove, 610, 314, 0
Click
Sleep 200
Send ^v
Sleep 200
MouseMove, 729, 1008, 0
Click
return

; JE <1.20 Create World Script
World_120:
MouseMove, 957, 457, 0
Click
Sleep 200
MouseMove, 1205, 932, 0
Click
Sleep 200
Send ^a
Sleep 80
Send ^v
Sleep 200
MouseMove, 742, 336, 0
Sleep 200
Click 2
Sleep 200
MouseMove, 1233, 586, 0
Click
Sleep 200
MouseMove, 956, 219, 0
Click
Sleep 200
Send ^v
Sleep 200
MouseMove, 722, 1004, 0
Click
return