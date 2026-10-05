#NoEnv
#SingleInstance Force
SendMode Input

configFile := A_ScriptDir . "\snippets.ini"
keys := ["Numpad0","Numpad1","Numpad2","Numpad3","Numpad4","Numpad5","Numpad6","Numpad7","Numpad8","Numpad9"]

; Bind each numpad key with Ctrl held (Ctrl+Numpad0, Ctrl+Numpad1, etc.)
; so your numpad still works normally for typing numbers.
Loop % keys.Length() {
    key := keys[A_Index]
    Hotkey, ^%key%, PasteSnippet
}

; Also bind Ctrl+Shift+number row (Ctrl+Shift+0, Ctrl+Shift+1, etc.)
; mapped to the same snippets as the matching numpad key.
Loop, 10 {
    digit := A_Index - 1
    Hotkey, ^+%digit%, PasteSnippet
}
return

PasteSnippet:
    ; Last char of the hotkey is the digit for both ^Numpad# and ^+# forms
    keyPressed := "Numpad" . SubStr(A_ThisHotkey, 0)
    IniRead, snippetText, %configFile%, Snippets, %keyPressed%, %A_Space%
    if (snippetText != "") {
        savedClip := ClipboardAll
        Clipboard := snippetText
        Send ^v
        Sleep 100
        Clipboard := savedClip
        savedClip := ""
    }
return