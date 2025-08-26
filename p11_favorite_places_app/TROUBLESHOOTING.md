# Troubleshooting Guide

## App Crash and Performance Issues

Your Flutter app was experiencing crashes and performance issues. Here's how to fix them:

### 🔧 Issues Fixed

1. **Environment Initialization Crashes**: The app was throwing errors when the `.env` file was missing
2. **Performance Issues**: Location services and network calls were blocking the main thread
3. **Timeout Issues**: No timeout handling for async operations
4. **State Management**: Potential setState calls on unmounted widgets

### 📋 Steps to Fix

#### 1. Create the `.env` File

The app requires a Google Maps API key to function properly. You have two options:

**Option A: Use the provided script (Recommended)**
```bash
# Run the PowerShell script
.\create_env_file.ps1

# Or run the batch script
.\create_env_file.bat
```

**Option B: Create manually**
Create a file named `.env` in the project root with:
```
GOOGLE_MAPS_API_KEY=your_actual_google_maps_api_key_here
```

#### 2. Get a Google Maps API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable these APIs:
   - **Maps Static API**
   - **Geocoding API**
4. Go to "Credentials" → "Create Credentials" → "API Key"
5. Copy the API key and add it to your `.env` file

#### 3. Restart the App

```bash
# Stop the current app (Ctrl+C in terminal)
# Then restart
flutter run
```

### 🚀 Performance Improvements Made

1. **Timeout Handling**: Added 5-10 second timeouts to prevent hanging
2. **Error Handling**: Graceful fallbacks when API key is missing
3. **State Safety**: Added `mounted` checks before setState calls
4. **Request Prevention**: Prevent multiple simultaneous location requests
5. **Async Optimization**: Better async operation handling

### 🔍 Debug Information

The app will now show helpful debug messages:

- ✅ **Success**: "Environment variables loaded from .env file"
- ✅ **Success**: "Google Maps API key is available and ready to use"
- ⚠️ **Warning**: "GOOGLE_MAPS_API_KEY not found in environment variables"
- ❌ **Error**: "Error getting location: [details]"

### 🧪 Testing

After setting up the API key:

1. **Location Feature**: Tap "Get current location" - should work smoothly
2. **Map Preview**: Should show a map image when location is selected
3. **Address Resolution**: Should display the actual address, not coordinates
4. **Performance**: No more "Skipped frames" warnings

### 🆘 If Issues Persist

1. **Check API Key**: Ensure it's valid and has the required APIs enabled
2. **Network**: Make sure you have internet connection for geocoding
3. **Permissions**: Grant location permissions when prompted
4. **Restart**: Sometimes a full restart of the emulator helps

### 📱 Expected Behavior

- App starts without crashes
- Location button responds quickly
- Map images load properly
- Addresses are resolved correctly
- No performance warnings in console

---

**Note**: The `.env` file is in `.gitignore` for security, so you'll need to create it on each machine where you run the app.
