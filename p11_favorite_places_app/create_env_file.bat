@echo off
echo Creating .env file for Google Maps API key...
echo.
echo Please enter your Google Maps API key:
set /p API_KEY=
echo GOOGLE_MAPS_API_KEY=%API_KEY% > .env
echo.
echo .env file created successfully!
echo.
echo Next steps:
echo 1. Make sure your API key has the following APIs enabled:
echo    - Maps Static API
echo    - Geocoding API
echo 2. Run 'flutter pub get' to ensure dependencies are up to date
echo 3. Restart your Flutter app
echo.
pause
