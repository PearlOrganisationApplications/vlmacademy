@echo off
echo ==========================================
echo VLM Academy Crash Diagnoser
echo ==========================================
echo.
echo 1. Checking Flutter Environment...
call flutter doctor -v > debug_report.txt 2>&1

echo.
echo 2. Checking Connected Devices...
call flutter devices >> debug_report.txt 2>&1

echo.
echo 3. Capturing Crash Logs...
echo (Please ensure your device is connected and you just reproduced the crash)
call adb logcat -d > crash_logs.txt 2>&1

echo.
echo ==========================================
echo DIAGNOSTIC COMPLETE
echo ==========================================
echo Please upload the following files from your project folder:
echo - debug_report.txt
echo - crash_logs.txt
echo.
pause
