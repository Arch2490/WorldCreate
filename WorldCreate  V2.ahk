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
Gui, Add, Text,, Select World Type:
Gui, Add, DropDownList, vWorldTypeChoice w220, Default|Superflat|Large Biomes|Amplified|Single Biome|
Gui, Add, Text,, Paste Seeds (one per line):
Gui, Add, Edit, vSeedBox w460 r12
Gui, Add, Button, gLoadSeeds w140, Load Seeds
Gui, Add, Text, vStatus w460, No seeds loaded.
Gui, Add, Text,, Hotkeys:
Gui, Add, Text,, • Press F6 to load next world
Gui, Add, Text,, • Press F7 to exit world
Gui, Add, Text,, • Press F8 to Delete last checked seed from exiting
Gui, Show,, WorldCreate
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

if (MCVersionChoice = "JE 1.21+") ; for java 1.21+
{
	if (WorldTypeChoice = "Default")
    		Gosub, World_121_Default
	else if (WorldTypeChoice = "Superflat")
		Gosub, World_121_Superflat
	else if (WorldTypeChoice = "Large Biomes")
		Gosub, World_121_LB
	else if (WorldTypeChoice = "Amplified")
		Gosub, World_121_Amplified
	else if (WorldTypeChoice = "Single Biome")
		Gosub, World_121_SingleBiome
}
if (MCVersionChoice = "JE ≤1.20") ; for java <1.20
{
	if (WorldTypeChoice = "Default")
    		Gosub, World_120_Default
	else if (WorldTypeChoice = "Superflat")
		Gosub, World_120_Superflat
	else if (WorldTypeChoice = "Large Biomes")
		Gosub, World_120_LB
	else if (WorldTypeChoice = "Amplified")
		Gosub, World_120_Amplified
	else if (WorldTypeChoice = "Single Biome")
		Gosub, World_120_SingleBiome
}

currentIndex++
return

F7::
Gui, Submit, NoHide
if (MCVersionChoice = "JE 1.21+")
    		Send {Esc}{Up}{Enter}
	else
    		Send {Esc}{Tab 8}{Enter}
	return

F8::
Gui, Submit, NoHide
if (MCVersionChoice = "JE 1.21+") {
    Send {Esc}{Up}{Enter}
    Sleep 3500
    Send {Enter}{Tab 5}
    Sleep 100
    Send {Enter 2}
    return
}
else if (MCVersionChoice = "JE ≤1.20") {
    Send {Esc}{Tab 8}{Enter}
    Sleep 3500
    Send {Tab}{Enter}
    Sleep 200
    Send {Tab 5}
    Sleep 100
    Send {Enter}{Tab}{Enter}
    return
}
; ===============================================

; JE >1.21 Default Create World Script
World_121_Default:
Send {Down 10}
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}
Send {Enter}
Sleep 800
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Up 2}
Sleep 70
Send {Right}	
Sleep 70
Send {Tab 2} 
Sleep 70
Send ^v
Sleep 70
Send {Tab 3}
Sleep 70
Send {Enter}
return

; JE <1.20 Default Create World Script
World_120_Default:
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}{Enter}
Sleep 70
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Tab 5}{Enter}
Sleep 70
Send {Tab 3}
Sleep 70
Send ^v
Sleep 70
Send {Tab 6}
Sleep 70
Send {Enter}
return
; ===============================================
; JE >1.21 Superflat Create World Script
World_121_Superflat:
Send {Down 10}
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}
Send {Enter}
Sleep 800
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Up 2}
Sleep 70
Send {Right}	
Sleep 70
Send {Tab}{Enter} ; world type
Sleep 50
Send {Tab 2}
Sleep 70
Send ^v
Sleep 70
Send {Tab 3}
Sleep 70
Send {Enter}
return

; JE <1.20 Superflat Create World Script
World_120_Superflat:
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}{Enter}
Sleep 70
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Tab 5}{Enter}
Sleep 70
Send {Tab 3}
Sleep 70
Send ^v
Sleep 70
Send {Tab 2}{Enter} ; world type
Sleep 70
Send {Tab 5}{Enter}
return
; ===============================================
; JE >1.21 Large Biomes Create World Script
World_121_LB:
Send {Down 10}
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}
Send {Enter}
Sleep 800
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Up 2}
Sleep 70
Send {Right}	
Sleep 70
Send {Tab}{Enter 2} ; world type
Sleep 50
Send {Tab}
Sleep 70
Send ^v
Sleep 70
Send {Tab 3}
Sleep 70
Send {Enter}
return


; JE <1.20 Large Biomes Create World Script
World_120_LB:
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}{Enter}
Sleep 70
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Tab 5}{Enter}
Sleep 70
Send {Tab 3}
Sleep 70
Send ^v
Sleep 70
Send {Tab 2}{Enter 2} ; world type
Sleep 70
Send {Tab 5}
; ===============================================
; JE >1.21 Amplified Create World Script
World_121_Amplified:
Send {Down 10}
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}
Send {Enter}
Sleep 800
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Up 2}
Sleep 70
Send {Right}	
Sleep 70
Send {Tab}{Enter 3} ; world type
Sleep 50
Send {Tab}
Sleep 70
Send ^v
Sleep 70
Send {Tab 3}
Sleep 70
Send {Enter}
return


; JE <1.20 Amplified Create World Script
World_120_Amplified:
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}{Enter}
Sleep 70
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Tab 5}{Enter}
Sleep 70
Send {Tab 3}
Sleep 70
Send ^v
Sleep 70
Send {Tab 2}{Enter 3} ; world type
Sleep 70
Send {Tab 5}
return
; ===============================================
; JE >1.21 Single Biome Create World Script
World_121_SingleBiome:
Send {Down 10}
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}
Send {Enter}
Sleep 800
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Up 2}
Sleep 70
Send {Right}	
Sleep 70
Send {Tab}{Enter 4} ; world type
Sleep 70
Send {Tab}{Enter}
Sleep 500
MsgBox, 64, Biome Selection, Please choose the Biome.
return

; JE <1.20 Single Biome Create World Script
World_120_SingleBiome:
Send {Tab}
Send {Enter}
Sleep 70
Send {Tab 3}{Enter}
Sleep 70
Send ^a
Sleep 70
Send ^v
Sleep 70
Send {Tab}{Enter 2}
Sleep 70
Send {Tab 5}{Enter}
Sleep 70
Send {Tab 3}
Sleep 70
Send ^v
Sleep 70
Send {Tab 2}{Enter 4} ; world type
Sleep 70
Send {Tab}{Enter}
Sleep 500
MsgBox, 64, Biome Selection, Please choose the Biome.
return