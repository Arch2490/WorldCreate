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

; ===============================================

; Leave world hotkey (F7)
F7:: 	; you can also change this one too
Send {esc}
Sleep 75
MouseMove, 960, 625, 0
Click
return

; Leave world and delete last checked seedhotkey (F8)
F8:: 	; you can also change this one too
Send {esc}
Sleep 75
MouseMove, 960, 625, 0
Click
Sleep 2000

MouseMove, 960, 420, 0
Click
Sleep 200
MouseMove, 960, 200, 0
Sleep 200
MouseMove, 900, 200, 0
Click
Sleep 200
MouseMove, 850, 1000, 0
Click
Sleep 200
MouseMove, 717, 491, 0
Click
Sleep 200
return

; ===============================================

; JE >1.21 Default Create World Script
World_121_Default:
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

; JE <1.20 Default Create World Script
World_120_Default:
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
; ===============================================
; JE >1.21 Superflat Create World Script
World_121_Superflat:
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
MouseMove, 730, 195, 0
Click
Sleep 200
MouseMove, 729, 1008, 0
Click
return

; JE <1.20 Superflat Create World Script
World_120_Superflat:
MouseMove, 970, 419, 0
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
MouseMove, 1209, 339, 0
Click
Sleep 200
MouseMove, 722, 1004, 0
Click
return
; ===============================================
; JE >1.21 Large Biomes Create World Script
World_121_LB:
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
MouseMove, 730, 195, 0
Click 2
Sleep 200
MouseMove, 729, 1008, 0
Click
return

; JE <1.20 Large Biomes Create World Script
World_120_LB:
MouseMove, 970, 419, 0
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
MouseMove, 1209, 339, 0
Click 2
Sleep 200
MouseMove, 722, 1004, 0
Click
return
; ===============================================
; JE >1.21 Amplified Create World Script
World_121_Amplified:
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
MouseMove, 730, 195, 0
Click 3
Sleep 200
MouseMove, 729, 1008, 0
Click
return

; JE <1.20 Amplified Create World Script
World_120_Amplified:
MouseMove, 970, 419, 0
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
MouseMove, 1209, 339, 0
Click 3
Sleep 200
MouseMove, 722, 1004, 0
Click
return
; ===============================================
; JE >1.21 Single Biome Create World Script
World_121_SingleBiome:
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
MouseMove, 730, 195, 0
Click 4
Sleep 200
MouseMove, 1201, 190, 0
Click
Sleep 500
MsgBox, 64, Biome Selection, Please choose the Biome.
return

; JE <1.20 Single Biome Create World Script
World_120_SingleBiome:
MouseMove, 970, 419, 0
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
MouseMove, 1209, 339, 0
Click 4
Sleep 200
MouseMove, 1205, 402, 0
Click
Sleep 500
MsgBox, 64, Biome Selection, Please choose the Biome.
return