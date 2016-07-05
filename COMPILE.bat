del "Release\*.exe"
for %%a in (AUMBI.nsi) do "C:\Program Files (x86)\NSIS\makensis.exe" %%a
pause
for %%a in (AUMBI.nsi) do "C:\Program Files\NSIS\makensis.exe" %%a
pause
