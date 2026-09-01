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

PasteSnippet:
    keyPressed := SubStr(A_ThisHotkey, InStr(A_ThisHotkey, "Numpad"))
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