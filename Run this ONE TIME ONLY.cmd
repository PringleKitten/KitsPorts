@echo off
echo ------------------------------------------------------------
echo If you are updating to Version 4.1 of this mod CONTINUE
echo This is to fix issues with settings and scores being broken
echo Due to the new system I made
echo ------------------------------------------------------------
pause
set "targetFolder=%APPDATA%\PringleKitten"

echo Attempting to delete folder: %targetFolder%
if exist "%targetFolder%" (
    rmdir /s /q "%targetFolder%"
    echo Folder deleted successfully.
) else (
    echo Folder does not exist.
)
pause
