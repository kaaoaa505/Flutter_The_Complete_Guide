@echo off
echo 🚀 Setting up Shopping List App...
echo ==================================

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js is not installed. Please install Node.js first.
    pause
    exit /b 1
)

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed. Please install Flutter first.
    pause
    exit /b 1
)

echo ✅ Node.js and Flutter are installed

REM Setup Backend
echo.
echo 📦 Setting up Backend...
cd backend_app

if not exist "node_modules" (
    echo Installing backend dependencies...
    npm install
    if %errorlevel% neq 0 (
        echo ❌ Failed to install backend dependencies
        pause
        exit /b 1
    )
) else (
    echo ✅ Backend dependencies already installed
)

cd ..

REM Setup Frontend
echo.
echo 📱 Setting up Frontend...
cd frontend_app

echo Installing Flutter dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo ❌ Failed to install Flutter dependencies
    pause
    exit /b 1
)

cd ..

echo.
echo ✅ Setup completed successfully!
echo.
echo 🚀 To start the application:
echo.
echo 1. Start the backend server:
echo    cd backend_app
echo    npm run dev
echo.
echo 2. In a new terminal, start the Flutter app:
echo    cd frontend_app
echo    flutter run
echo.
echo 🌐 Backend will be available at: http://localhost:3000
echo 📱 Flutter app will run on your device/emulator
pause
