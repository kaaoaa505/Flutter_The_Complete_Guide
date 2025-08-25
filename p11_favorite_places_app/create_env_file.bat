@echo off
echo Creating .env file for Google Maps API key...
echo.
echo Please enter your Google Maps API key:
set /p API_KEY=
echo.
echo Creating .env file...
echo GOOGLE_MAPS_API_KEY=%API_KEY% > .env
echo.
echo .env file created successfully!
echo.
pause
