去除

```bash
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
taskkill /f /im explorer.exe
attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db"
del "%userprofile%\AppData\Local\iconcache.db" /f /q
start explorer
pause
```

恢复

```bash
reg delete HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindowsCurrentVersionExplorerShell Icons v 29 f
taskkill f im explorer.exe
attrib -s -r -h %userprofile%AppDataLocaliconcache.db
del %userprofile%AppDataLocaliconcache.db f q
start explorer
pause
```

