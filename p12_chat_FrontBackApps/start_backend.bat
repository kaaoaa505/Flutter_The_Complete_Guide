@echo off
echo Starting Laravel Backend Server...
echo.
cd backend\chat_backend
echo Current directory: %CD%
echo.
echo Installing PHP dependencies...
composer install
echo.
echo Generating application key...
php artisan key:generate
echo.
echo Running database migrations...
php artisan migrate
echo.
echo Starting Laravel development server...
echo Server will be available at: http://localhost:8000
echo Press Ctrl+C to stop the server
echo.
php artisan serve --host=0.0.0.0 --port=8000
pause
