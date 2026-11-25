#Requires AutoHotkey v2.0
#SingleInstance Force
; See README.md for KONNECT bindings and usage.

InstallKeybdHook()
InstallMouseHook()

OnExit(ReleaseAlt)

Layer1Used := false
Layer2Used := false
AltHeld := false

; F12::KeyHistory()

; Layer buttons

*MButton::{
    global Layer1Used, Layer2Used

    ReleaseAlt()
    Layer1Used := false

    if GetKeyState("XButton1", "P") {
        Layer1Used := true
        Layer2Used := true
        Send "^r"
        return
    }

    if GetKeyState("LButton", "P")
        || GetKeyState("RButton", "P")
        MarkLayerUsed()
}

*MButton Up::{
    global Layer1Used

    if !Layer1Used
        Send "{MButton}"

    Layer1Used := false
}

*XButton1::{
    global Layer1Used, Layer2Used

    ReleaseAlt()
    Layer2Used := false

    if GetKeyState("MButton", "P") {
        Layer1Used := true
        Layer2Used := true
        Send "!{Right}"
        return
    }

    if GetKeyState("LButton", "P")
        || GetKeyState("RButton", "P")
        MarkLayerUsed()
}

*XButton1 Up::{
    global Layer2Used

    if !Layer2Used
        Send "{XButton1}"

    Layer2Used := false
}

~*LButton::MarkLayerUsed()
~*RButton::MarkLayerUsed()

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

; Layer 1: hold MButton

#HotIf GetKeyState("MButton", "P")

*NumpadDiv::AdjustBrightness(-5)
*F15::AdjustBrightness(5)

NumpadAdd::SendAction("^{WheelUp}")
F18::SendAction("^{WheelDown}")

Numpad1::
NumpadEnd::SendAction("#v")

Numpad2::
NumpadDown::SendAction("^+v")

Numpad3::
NumpadPgDn::SendAction("{Volume_Down}")

Numpad4::
NumpadLeft::SendAction("{Volume_Up}")

~*WheelUp::MarkLayerUsed()
~*WheelDown::MarkLayerUsed()

; Layer 2: hold XButton1

#HotIf GetKeyState("XButton1", "P")

*NumpadDiv::SendAction("{WheelLeft}")
*F15::SendAction("{WheelRight}")

WheelUp::SendAction("{PgUp}")
WheelDown::SendAction("{PgDn}")

Numpad1::
NumpadEnd::SendAction("^w"

)

Numpad2::
NumpadDown::SendAction("^+t")

#HotIf

MarkLayerUsed() {
    global Layer1Used, Layer2Used

    if GetKeyState("MButton", "P")
        Layer1Used := true

    if GetKeyState("XButton1", "P")
        Layer2Used := true
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

AdjustBrightness(step) {
    MarkLayerUsed()
    ReleaseAlt()

    try {
        wmi := ComObjGet("winmgmts:\\.\root\WMI")

        monitors := wmi.ExecQuery(
            "SELECT * FROM WmiMonitorBrightness WHERE Active=TRUE"
        )

        methods := wmi.ExecQuery(
            "SELECT * FROM WmiMonitorBrightnessMethods WHERE Active=TRUE"
        )

        for monitor in monitors {
            level := Max(5, Min(100,
                monitor.CurrentBrightness + step))

            for method in methods {
                if method.InstanceName = monitor.InstanceName {
                    method.WmiSetBrightness(0, level)
                    break
                }
            }
        }
    }
    catch {
        ToolTip "Brightness control unavailable"
        SetTimer () => ToolTip(), -1000
    }
}
