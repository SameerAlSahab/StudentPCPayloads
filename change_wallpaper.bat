@echo off
setlocal

echo        StudentPCPaylods - Change Wallpaper
echo        Author: Sameer Al Sahab
echo        Edit FUNNY_WALLPAPER VAR FOR WALLPAPER ACTUAL LINK!!
echo.

set "THEMES=%AppData%\Microsoft\Windows\Themes"
set "BACKUP=%THEMES%\TranscodedWallpaper.bak"
set "WALLPAPER=%THEMES%\funnywallpaper.jpg"
set "FUNNY_WALLPAPER=https://images.unsplash.com/photo-1556997685-309989c1aa82?q=80&w=1173&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"

if not exist "%THEMES%" (
    echo ERROR: Windows Themes folder was not found.
    pause
    exit /b 1
)

echo Checking current wallpaper...

if exist "%THEMES%\TranscodedWallpaper" (
    copy /Y "%THEMES%\TranscodedWallpaper" "%BACKUP%" >nul
    echo Backup created:
    echo %BACKUP%
) else (
    echo No TranscodedWallpaper file found.
)

echo.
echo Downloading funny wallpaper...

curl.exe -L --fail --silent --show-error ^
    "%FUNNY_WALLPAPER%" ^
    -o "%WALLPAPER%"

if errorlevel 1 (
    echo.
    echo ERROR: Wallpaper download failed.
    echo Nothing was changed.
    pause
    exit /b 1
)

echo Download complete.

echo.
echo Replacing wallpaper cache...

copy /Y "%WALLPAPER%" "%THEMES%\TranscodedWallpaper" >nul

if errorlevel 1 (
    echo ERROR: Could not replace TranscodedWallpaper.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo Wallpaper changed successfully!
echo.
echo Restart or sign out of Windows
echo to apply the wallpaper.
echo ==========================================
echo.

pause
endlocal
