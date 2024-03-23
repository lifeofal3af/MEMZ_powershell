:xor
echo MsgBox "still using this computer?",vbExclamation,"lol" > Float2.vbs 
start Float2.vbs
timeout /t 120 /nobreak > nul
goto :xor