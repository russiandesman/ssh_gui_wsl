Dim objShortcut, objShell
Set objShell = WScript.CreateObject ("Wscript.Shell")
startupPath = objShell.SpecialFolders ("Startup")
desktopPath = objShell.SpecialFolders ("Desktop")

On Error Resume Next
x_folder = objShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\VcXsrv\Install_Dir_64")
if err.number <> 0 then
    WScript.Echo "Can not find installed VcXsrv, quitting"
    WScript.Quit
end if

'WScript.Echo "VcXSrv is at: " & x_folder
'WScript.Echo "Startup path: " & startupPath

' Create batch to autostart X server
Dim objFSO, outFile
Set objFSO = WScript.CreateObject("Scripting.FileSystemObject")
Set outFile = objFSO.CreateTextFile(startupPath & "\autostart_x_server.bat", True)
outFile.WriteLine "@echo off"
outFile.WriteLine "start /B ""Title:x-server"" """ &  x_folder & "\vcxsrv.exe"" :0 -multiwindow -ac -listen tcp"
outFile.Close

' Shottcuts cannot be pre-created (.lnk files contain info specific to creator unfortunately)
' so just create them here
Set objShortcut = objShell.CreateShortcut (desktopPath & "\Far2l.lnk")
objShortcut.TargetPath = "cscript.exe"
objShortcut.Arguments = "%USERPROFILE%\WSL\hide_console.vbs %USERPROFILE%\WSL\far_wsl_gui.bat"
objShortcut.IconLocation = "%USERPROFILE%\WSL\far2l.ico"
objShortcut.WorkingDirectory = "%USERPROFILE%\WSL"
objShortcut.Description = "Far2l linux port of Far manager"
objShortcut.Save

' port forwarding script has to be run each time VPN connects\disconnects, so cannot be autorunned
Set objShortcut = objShell.CreateShortcut (desktopPath & "\x_port_forward.lnk")
objShortcut.TargetPath = "%USERPROFILE%\WSL\x_port_forward.bat"
objShortcut.WorkingDirectory = "%USERPROFILE%\WSL"
objShortcut.Description = "Port forwarding for X server. Port forwarding script has to be run each time VPN connects\disconnects, so cannot be autorunned"
objShortcut.Save

WScript.Echo "Shortcuts added to desktop; Xserver added to Startup; Reboot Windows to try it out."

WScript.Quit
