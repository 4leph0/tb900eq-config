#Requires AutoHotkey v2.0
#SingleInstance Force
; See README.md for KONNECT bindings and usage.

InstallKeybdHook()
InstallMouseHook()

OnExit(ReleaseAlt)

Layer1Used := false
ForwardButtonHeld := false
AltHeld := false

; F12::KeyHistory()

; Layer button

*XButton1::{
    global Layer1Used

    ReleaseAlt()
    Layer1Used := false

    if GetKeyState("LButton", "P")
        || GetKeyState("RButton", "P")
        || GetKeyState("MButton", "P")
        MarkLayerUsed()
}

*XButton1 Up::{
    global Layer1Used

    if !Layer1Used
        Send "{XButton1}"

    Layer1Used := false
}

~*LButton::MarkLayerUsed()
~*RButton::MarkLayerUsed()
~*MButton::MarkLayerUsed()

; Layer 0

Numpad1::
NumpadEnd::SendAction("^c")

Numpad2::
NumpadDown::SendAction("^v")

Numpad3::
NumpadPgDn::SendAction("^z")

Numpad4::
NumpadLeft::SendAction("^y")

NumpadAdd::SendAction("^{Tab}")
F18::SendAction("^+{Tab}")

*NumpadDiv::AppSwitch(true)
*F15::AppSwitch(false)

; Layer 1: hold XButton1

#HotIf GetKeyState("XButton1", "P")

*MButton::{
    global ForwardButtonHeld

    ForwardButtonHeld := true
    SendAction("!{Right}")
}

*NumpadDiv::SendAction("{WheelLeft}")
*F15::SendAction("{WheelRight}")

WheelUp::SendAction("{PgDn}")
WheelDown::SendAction("{PgUp}")

NumpadAdd::SendAction("^{WheelUp}")
F18::SendAction("^{WheelDown}")

Numpad1::
NumpadEnd::SendAction("^a")

Numpad2::
NumpadDown::SendAction("^+v")

Numpad3::
NumpadPgDn::SendAction("{Volume_Down}")

Numpad4::
NumpadLeft::SendAction("{Volume_Up}")

; Suppress release even if the layer button was released first.

#HotIf ForwardButtonHeld

*MButton Up::{
    global ForwardButtonHeld

    ForwardButtonHeld := false
}

#HotIf

MarkLayerUsed() {
    global Layer1Used

    if GetKeyState("XButton1", "P")
        Layer1Used := true
}

SendAction(keys) {
    MarkLayerUsed()
    ReleaseAlt()
    Send keys
}

AppSwitch(reverse) {
    global AltHeld

    MarkLayerUsed()

    if !AltHeld {
        SendEvent "{Blind}{LAlt down}"
        AltHeld := true
    }

    if reverse
        SendEvent "{Blind}{LShift down}{Tab}{LShift up}"
    else
        SendEvent "{Blind}{Tab}"

    SetTimer ReleaseAlt, -600
}

ReleaseAlt(*) {
    global AltHeld

    SetTimer ReleaseAlt, 0

    if AltHeld {
        if !GetKeyState("LAlt", "P")
            SendEvent "{Blind}{LAlt up}"

        AltHeld := false
    }
}
