
Gui, Add, Picture, w300 h-1, bitbug_favicon (3).ico
Gui, Add, Picture, x300 y5 w300 h-1, bitbug_favicon (2).ico

gui, font, s12, Verdana 
Gui, Add, Button, Default x240 w150 h40, 变成猫猫回收站
Gui, Add, Button, Default x240 y360 w150 h40, 还原
Gui, Show,, 猫猫回收站
Return


Button还原:
RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon, , %SystemRoot%\System32\imageres.dll`,-55
RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon, empty, %SystemRoot%\System32\imageres.dll`,-55
RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon, full, %SystemRoot%\System32\imageres.dll`,-54
;Run, reflash.bat
RunWaitMany("
(
rem @echo off
taskkill /f /im explorer.exe
explorer.exe
)")
Return

Button变成猫猫回收站:
RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon, , %A_ScriptDir%\bitbug_favicon (3).dll`,0
RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon, empty, %A_ScriptDir%\bitbug_favicon (3).dll`,0
RegWrite, REG_EXPAND_SZ, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon, full, %A_ScriptDir%\bitbug_favicon (2).dll`,0
;Run, reflash.bat
RunWaitMany("
(
rem @echo off
taskkill /f /im explorer.exe
explorer.exe
)")
Return

GuiClose:
ExitApp

 
RunWaitMany(commands) {
    shell := ComObjCreate("WScript.Shell")
    ; 打开 cmd.exe 禁用命令显示
    exec := shell.Exec(ComSpec " /Q /K echo off")
    ; 发送并执行命令,使用新行分隔
    exec.StdIn.WriteLine(commands "`nexit")  ; 保证执行完毕后退出!
    ; 读取并返回所有命令的输出
    return exec.StdOut.ReadAll()
}