#!/bin/bash

echo "🚀 Setting up Shopping List App..."
echo "=================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

echo "✅ Node.js and Flutter are installed"

# Setup Backend
echo ""
echo "📦 Setting up Backend..."
cd backend_app

if [ ! -d "node_modules" ]; then
    echo "Installing backend dependencies..."
    npm install
    if [ $? -ne 0 ]; then
        echo "❌ Failed to install backend dependencies"
        exit 1
    fi
else
    echo "✅ Backend dependencies already installed"
fi

cd ..

# Setup Frontend
echo ""
echo "📱 Setting up Frontend..."
cd frontend_app

echo "Installing Flutter dependencies..."
flutter pub get
if [ $? -ne 0 ]; then
    echo "❌ Failed to install Flutter dependencies"
    exit 1
fi

cd ..

echo ""
echo "✅ Setup completed successfully!"
echo ""
echo "🚀 To start the application:"
echo ""
echo "1. Start the backend server:"
echo "   cd backend_app"
echo "   npm run dev"
echo ""
echo "2. In a new terminal, start the Flutter app:"
echo "   cd frontend_app"
echo "   flutter run"
echo ""
echo "🌐 Backend will be available at: http://localhost:3000"
echo "📱 Flutter app will run on your device/emulator"
