; If you want to change the hotkeys, you need to have Autohotkey instaled on your PC first, then go to line 56 for F6, line 120 for F7, line 128 for F8, line 136 for F9, and line 138 to replace the "t" to whatever keybind you have set if you have changed it. By default its set to t.

; Any versions older then 1.14 wont work as tab enter navigation wasnt added till 1.14. everything is pretty much done so this might be the final version, im reletively happy with the features.

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
Gui, Add, DropDownList, vMCVersionChoice w220, JE ≥1.19.4|JE 1.16–1.19.3|JE 1.14–1.15.2
Gui, Add, Text,, Select World Type:
Gui, Add, DropDownList, vWorldTypeChoice w220, Default|Superflat|Large Biomes|Amplified|Single Biome|
Gui, Add, Text,, Paste Seeds (one per line):
Gui, Add, Edit, vSeedBox w460 r12
Gui, Add, Button, gLoadSeeds w140, Load Seeds
Gui, Add, Text, vStatus w460, No seeds loaded.
Gui, Add, Text,, Hotkeys:
Gui, Add, Text,, • Press F6 to load next world
Gui, Add, Text,, • Press F7 to exit world
Gui, Add, Text,, • Press F8 to Delete last checked seed on Main Menu
Gui, Font, s10, Segoe UI
Gui, Add, Text, x+-40 y10 right cGray vCreditText, by Arch2490/@4rch249
Gui, Add, Text, x+-92 y29 right cGray vWCVersion, WorldCreate V3
Gui, Show,, WorldCreate V3
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
    if (seeds.Length() > 0) {
        word := (seeds.Length() = 1 ? "seed" : "seeds")
        GuiControl,, Status, % "Loaded " seeds.Length() " " word "."
    } else {
        GuiControl,, Status, No seeds loaded.
    }
return

; Create World hotkey (F6)
F6::	; you can change this hotkey to whatever you want
if (seeds.Length() = 0) {
    MsgBox, 48, Error, Please load seeds first!
    return
}
if (currentIndex > seeds.Length()) {
    MsgBox, 64, Done, All seeds have been checked.
    GuiControl,, Status, All seeds have been checked.
    Hotkey, F6, Off  ; disable the F6 hotkey
    return
}

; Update status with counter
GuiControl,, Status, % "Creating seed " currentIndex "/" seeds.Length() "…"

; Copy next seed to clipboard
Clipboard := seeds[currentIndex]
ClipWait, 0.5

; Run macro depending on version
Gui, Submit, NoHide

if (MCVersionChoice = "JE ≥1.19.4") ; for java 1.19.4 and above
{
	if (WorldTypeChoice = "Default")
    		Gosub, World_1194_Default
	else if (WorldTypeChoice = "Superflat")
		Gosub, World_1194_Superflat
	else if (WorldTypeChoice = "Large Biomes")
		Gosub, World_1194_LB
	else if (WorldTypeChoice = "Amplified")
		Gosub, World_1194_Amplified
	else if (WorldTypeChoice = "Single Biome")
		Gosub, World_1194_SingleBiome
}
if (MCVersionChoice = "JE 1.16–1.19.3") ; for java 1.16 to 1.19.3
{
	if (WorldTypeChoice = "Default")
    		Gosub, World_1193_Default
	else if (WorldTypeChoice = "Superflat")
		Gosub, World_1193_Superflat
	else if (WorldTypeChoice = "Large Biomes")
		Gosub, World_1193_LB
	else if (WorldTypeChoice = "Amplified")
		Gosub, World_1193_Amplified
	else if (WorldTypeChoice = "Single Biome")
		Gosub, World_1193_SingleBiome
}
if (MCVersionChoice = "JE 1.14–1.15.2") ; for java 1.19.3 and below
{
	if (WorldTypeChoice = "Default")
    		Gosub, World_1152_Default
	else if (WorldTypeChoice = "Superflat")
		Gosub, World_1152_Superflat
	else if (WorldTypeChoice = "Large Biomes")
		Gosub, World_1152_LB
	else if (WorldTypeChoice = "Amplified")
		Gosub, World_1152_Amplified
	else if (WorldTypeChoice = "Single Biome")
		Gosub, World_1152_SingleBiome
}
currentIndex++
return

F7::
Gui, Submit, NoHide
if (MCVersionChoice = "JE ≥1.19.4")
    		Send {Esc}{Up}{Enter}
	else
    		Send {Esc}{Tab 8}{Enter}
	return

F8::
Gui, Submit, NoHide
if (MCVersionChoice = "JE ≥1.19.4") {
    Send {Tab}{Enter}
    Send {Enter}{Tab 5}
    Sleep 100
    Send {Enter 2}
    return
}

else if (MCVersionChoice = "JE 1.16–1.19.3") {
    Send {Tab}{Enter}
    Sleep 200
    Send {Tab 5}
    Sleep 100
    Send {Enter}{Tab}{Enter}
    return
}
else if (MCVersionChoice = "JE 1.14–1.15.2") {
    Send {Tab}{Enter}
    Sleep 200
    Send {Tab 5}
    Sleep 100
    Send {Enter}{Tab}{Enter}
    return
}

F9::
Clipboard := "/seed"
Send, t
Sleep 40
Send, ^v
Send, {Enter}
return
; ===============================================

; JE ≥1.19.4 Default Create World Script
World_1194_Default:
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

; JE 1.16–1.19.3 Default Create World Script
World_1193_Default:
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

; JE 1.14–1.15.2 Default Create World Script
World_1152_Default:
Send {Tab}
Send {Enter}
Sleep 50
Send {Tab 4}
Send {Enter}
Send {Tab}
Sleep 50
Send ^a
Sleep 50
Send ^v
Sleep 50
Send {Tab}{Enter 2}{Tab}	
Send {Enter}
Sleep 50
Send {Tab 3}
Sleep 50
Send ^v
Sleep 50
Send {Tab 6}{Enter}
return
; ===============================================
; JE ≥1.19.4 Superflat Create World Script
World_1194_Superflat:
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
Send {Tab}{Enter}
Sleep 50
Send {Tab 2}
Sleep 70
Send ^v
Sleep 70
Send {Tab 3}
Sleep 70
Send {Enter}
return

; JE 1.16–1.19.3 Superflat Create World Script
World_1193_Superflat:
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
Send {Tab 2}{Enter}
Sleep 70
Send {Tab 5}{Enter}
return

; JE 1.14–1.15.2 Superflat Create World Script
World_1152_Superflat:
Send {Tab}
Send {Enter}
Sleep 50
Send {Tab 4}
Send {Enter}
Send {Tab}
Sleep 50
Send ^a
Sleep 50
Send ^v
Sleep 50
Send {Tab}{Enter 2}{Tab}	
Send {Enter}
Sleep 50
Send {Tab 3}
Sleep 50
Send ^v
Sleep 50
Send {Tab 2}{Enter}
Send +{Tab 4}
Send {Enter}
return
; ===============================================
; JE ≥1.19.4 Large Biomes Create World Script
World_1194_LB:
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
Send {Tab}{Enter 2}
Sleep 50
Send {Tab}
Sleep 70
Send ^v
Sleep 70
Send {Tab 3}
Sleep 70
Send {Enter}
return


; JE 1.16–1.19.3 Large Biomes Create World Script
World_1193_LB:
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
Send {Tab 2}{Enter 2}
Sleep 70
Send {Tab 5}

; JE 1.14–1.15.2 Large Biomes Create World Script
World_1152_LB:
Send {Tab}
Send {Enter}
Sleep 50
Send {Tab 4}
Send {Enter}
Send {Tab}
Sleep 50
Send ^a
Sleep 50
Send ^v
Sleep 50
Send {Tab}{Enter 2}{Tab}	
Send {Enter}
Sleep 50
Send {Tab 3}
Sleep 50
Send ^v
Sleep 50
Send {Tab 2}{Enter 2}
Send +{Tab 4}
Send {Enter}
return
; ===============================================
; JE ≥1.19.4 Amplified Create World Script
World_1194_Amplified:
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
Send {Tab}{Enter 3}
Sleep 50
Send {Tab}
Sleep 70
Send ^v
Sleep 70
Send {Tab 3}
Sleep 70
Send {Enter}
return


; JE 1.16–1.19.3 Amplified Create World Script
World_1193_Amplified:
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
Send {Tab 2}{Enter 3}
Sleep 70
Send {Tab 5}
return


; JE 1.14–1.15.2 Amplified Create World Script
World_1152_Amplified:
Send {Tab}
Send {Enter}
Sleep 50
Send {Tab 4}
Send {Enter}
Send {Tab}
Sleep 50
Send ^a
Sleep 50
Send ^v
Sleep 50
Send {Tab}{Enter 2}{Tab}	
Send {Enter}
Sleep 50
Send {Tab 3}
Sleep 50
Send ^v
Sleep 50
Send {Tab 2}{Enter 3}
Send +{Tab 4}
Send {Enter}
return
; ===============================================
; JE ≥1.19.4 Single Biome Create World Script
World_1194_SingleBiome:
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
Send {Tab}{Enter 4}
Sleep 70
Send {Tab}{Enter}
Sleep 500
MsgBox, 64, Biome Selection, Please choose the Biome.
return

; JE 1.16–1.19.3 Single Biome Create World Script
World_1193_SingleBiome:
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
Send {Tab 2}{Enter 4}
Sleep 70
Send {Tab}{Enter}
Sleep 500
MsgBox, 64, Biome Selection, Please choose the Biome.
return

; JE 1.16–1.19.3 Single Biome Create World Script
World_1152_SingleBiome:
Send {Tab}
Send {Enter}
Sleep 50
Send {Tab 4}
Send {Enter}
Send {Tab}
Sleep 50
Send ^a
Sleep 50
Send ^v
Sleep 50
Send {Tab}{Enter 2}{Tab}	
Send {Enter}
Sleep 50
Send {Tab 3}
Sleep 50
Send ^v
Sleep 50
Send {Tab 2}{Enter 4}
Sleep 70
Send {Tab}{Enter}
Sleep 500
MsgBox, 64, Biome Selection, Please choose the Biome.
return

; ===============================================

; remnants of me reloading for making this script
^r::
Reload

; unnecesarry comments
; i dont like how its 400 lines, 266 of which being just the different version with world types
; im kinda sick writing this im coughing a lot
; i really hope this works flawlessly on all version but like im too lazy to test one by one
; i might potentiall add support for 1.12 (the older older ui before the 1.19.3 one) but idk if they do the tab and enter
; if all works fine this is final version
; chocolate ice cream tastes really bad it dosent taste like chocolate
; this has been an arch2490/4rch249 productions
; (and a chatgpt productions)