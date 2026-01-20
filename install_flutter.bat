@echo off
echo Installing Flutter...
echo.

REM Download Flutter
echo Step 1: Downloading Flutter SDK...
powershell -Command "Invoke-WebRequest -Uri 'https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip' -OutFile '%TEMP%\flutter.zip'"

REM Extract to C:\
echo Step 2: Extracting Flutter...
powershell -Command "Expand-Archive -Path '%TEMP%\flutter.zip' -DestinationPath 'C:\' -Force"

REM Add to PATH
echo Step 3: Adding Flutter to PATH...
setx PATH "%PATH%;C:\flutter\bin" /M

echo.
echo Flutter installed successfully!
echo Please RESTART PowerShell and run: flutter doctor
pause
