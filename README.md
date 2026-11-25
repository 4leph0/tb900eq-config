# TB900 EQ Config

KONNECT profile and AutoHotkey v2 script for the Kensington TB900 EQ trackball.
KONNECT maps physical inputs to key codes, while AutoHotkey handles layers and custom actions.

## Files

| File | Description |
| --- | --- |
| `Konnect_profile.db` | Profile exported from KONNECT as a SQLite database |
| `tb900eq.ahk` | AutoHotkey v2 script defining layers, button actions, and wheel behavior |

## Requirements and Setup

- Windows 11
- Kensington KONNECT (version recorded in the exported database: `2.3.28.0`)
- AutoHotkey v2.0 or later
- Kensington TB900 EQ

1. Back up your existing KONNECT settings.
2. Import `Konnect_profile.db` using KONNECT's profile import feature and select `Profile_AHK`, which contains the key mappings required by the script.
3. Run `tb900eq.ahk` with AutoHotkey v2.

## KONNECT Input Bindings

The script expects the following key codes from KONNECT.

| Physical Input | KONNECT Settings |
| --- | --- |
| ◣ Bottom-left button | `LButton` |
| ◢ Bottom-right button | `RButton` |
| ◤ Upper-left button | `MButton` (Layer 1) |
| ◥ Upper-right button | `XButton1` (Layer 2) |
| ⬬₁ Top button 1 | `Numpad1` / `NumpadEnd` |
| ⬬₂ Top button 2 | `Numpad2` / `NumpadDown` |
| ⬬₃ Top button 3 | `Numpad3` / `NumpadPgDn` |
| ⬬₄ Top button 4 | `Numpad4` / `NumpadLeft` |
| ◖ Left wheel, clockwise | `F15` (`NumpadMult`) |
| ◖ Left wheel, counterclockwise | `NumpadDiv` |
| ○ Main wheel, clockwise | `WheelDown` |
| ○ Main wheel, counterclockwise | `WheelUp` |
| ◗ Right wheel, clockwise | `NumpadAdd` |
| ◗ Right wheel, counterclockwise | `F18` (`NumpadSub`) |

### Observed KONNECT Quirks

These behaviors were noted in the original configuration:

- KONNECT's `NumpadMult` binding emits `F15`, and `NumpadSub` emits `F18`.
- `Numpad1`–`Numpad4` may emit navigation keys depending on NumLock.
- With the default KONNECT mappings, the right wheel's input was not reliably detected in AutoHotkey's key history. Numpad keys were assigned in KONNECT so the script could detect and handle the wheel input.

## Layers

| Layer | ◣ | ◢ | ◤ | ◥ | ◖ | ○ | ◗ | ⬬₁ | ⬬₂ | ⬬₃ | ⬬₄ |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 0 | L🖱 | R🖱 | M🖱 | ← | ⎇⇥ | ↕ | ⌃⇥ | ⌃C | ⌃V | ↶ | ↷ |
| 1 | - | - | x | → | ☀ ± | - | 🔍 ± | ⊞V | ⌃⇧V | 🔉 − | 🔊 + |
| 2 | - | - | ⟳ | x | ↔ | ⇞ ⇟ | - | ▱ × | ▱ ↶ | - | - |

Hold ◤ for Layer 1 or ◥ for Layer 2.

The four primary buttons (◣ ◢ ◤ ◥) in Layer 0 and their native button combinations are configured in KONNECT.

**Legend**

- `x` marks the button held to activate the current layer.
- Inherit (`-`) means using the same action as Layer 0 for that input. Both Layer 1 and Layer 2 inherit directly from Layer 0; Layer 2 does not inherit from Layer 1.
- ▱ × = close tab; ▱ ↶ = restore tab.
- ← / → = browser back / forward; ⟳ = refresh.
- ↕ = vertical scrolling; ↔ = horizontal scrolling; ⇞ / ⇟ = Page Up / Down.
- ↶ / ↷ = undo / redo.

## Notes

- Middle-button dragging is not supported: holding ◤ activates Layer 1, and a standalone middle click is sent only when the button is released.
- The Alt+Tab implementation releases Alt 600 ms after the last app-switching wheel input.
- `F12` opens AutoHotkey's key history (currently commented out in the script).
- The top buttons handle both numeric keypad and navigation key codes to accommodate either NumLock state.
- Brightness adjustment requires a display that supports Windows WMI brightness control.
- The script handles inputs globally and does not distinguish input devices. Matching keys on a physical keyboard, including numpad `1`–`4`, `+`, and `/`, also trigger the mapped actions while the script is running.
- **This script is not suitable as-is if you use your keyboard's numeric keypad.** Bind the trackball inputs in KONNECT to keys you do not use on your keyboard, then create a new version of the AutoHotkey script using those bindings.
