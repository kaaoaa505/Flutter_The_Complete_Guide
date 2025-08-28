@echo off
echo Starting Flutter Frontend Application...
echo.
cd frontend\chat_app
echo Current directory: %CD%
echo.
echo Installing Flutter dependencies...
flutter pub get
echo.
echo Starting Flutter application...
echo Make sure the Laravel backend is running on http://localhost:8000
echo.
flutter run
pause
