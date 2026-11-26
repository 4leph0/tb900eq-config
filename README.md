# TB900 EQ Config

KONNECT profile and AutoHotkey v2 script for the Kensington TB900 EQ trackball.
KONNECT maps physical inputs to key codes, while AutoHotkey handles layers and custom actions.

This `one-layer` variant uses one momentary layer on ◥ and preserves native middle-button input on ◤.

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

## KONNECT Input Bindings & Layers

The script expects the following key codes from KONNECT and maps them to the actions shown for each layer.

| Physical Input | KONNECT Settings | Layer0 | Layer1 |
| --- | --- | :---: | :---: |
| ◣ Bottom-left button | `LButton` | L🖱 | - |
| ◢ Bottom-right button | `RButton` | R🖱 | - |
| ◤ Upper-left button | `MButton` | M🖱 | ▶ |
| ◥ Upper-right button | `XButton1` | ◀ | Held for Layer1 |
| ⬬₁ Top button 1 | `Numpad1` / `NumpadEnd` | ⌃C | ⌃A |
| ⬬₂ Top button 2 | `Numpad2` / `NumpadDown` | ⌃V | ⌃⇧V |
| ⬬₃ Top button 3 | `Numpad3` / `NumpadPgDn` | ↶ undo | VolDn |
| ⬬₄ Top button 4 | `Numpad4` / `NumpadLeft` | ↷ redo | VolUp |
| ◖ Left wheel, clockwise | `F15` (`NumpadMult`) | ⎇⇥ | Scroll → |
| ◖ Left wheel, counterclockwise | `NumpadDiv` | ⎇⇧⇥ | Scroll ← |
| ○ Main wheel, clockwise | `WheelDown` | Scroll ↓ | PgUp |
| ○ Main wheel, counterclockwise | `WheelUp` | Scroll ↑ | PgDn |
| ◗ Right wheel, clockwise | `NumpadAdd` | ⌃⇥ | Zoom in |
| ◗ Right wheel, counterclockwise | `F18` (`NumpadSub`) | ⌃⇧⇥ | Zoom out |

### Observed KONNECT Quirks

These behaviors were noted in the original configuration:

- KONNECT's `NumpadMult` binding emits `F15`, and `NumpadSub` emits `F18`.
- `Numpad1`–`Numpad4` may emit navigation keys depending on NumLock.
- With the default KONNECT mappings, the right wheel's input was not reliably detected in AutoHotkey's key history. Numpad keys were assigned in KONNECT so the script could detect and handle the wheel input.

## Notes

- The Alt+Tab implementation releases Alt 600 ms after the last app-switching wheel input.
- `F12` opens AutoHotkey's key history (currently commented out in the script).
- The top buttons handle both numeric keypad and navigation key codes to accommodate either NumLock state.
- The script handles inputs globally and does not distinguish input devices. Matching keys on a physical keyboard, including numpad `1`–`4`, `+`, and `/`, also trigger the mapped actions while the script is running.
- **This script is not suitable as-is if you use your keyboard's numeric keypad.** Bind the trackball inputs in KONNECT to keys you do not use on your keyboard, then create a new version of the AutoHotkey script using those bindings.
