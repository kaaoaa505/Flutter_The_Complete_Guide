@echo off
echo ========================================
echo Finding your computer's IP address...
echo ========================================
echo.

echo Your computer's IP addresses:
ipconfig | findstr "IPv4"

echo.
echo ========================================
echo For Flutter app configuration:
echo ========================================
echo.
echo If you're using Android emulator, use: 10.0.2.2
echo If you're using physical device, use your computer's IP (usually starts with 192.168.x.x)
echo.
echo Update the baseUrl in frontend_app/lib/data/categories_data.dart
echo.
pause
