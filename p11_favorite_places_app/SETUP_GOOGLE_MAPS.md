# Google Maps API Setup Guide

## Prerequisites
1. A Google Cloud Platform account
2. A Google Maps API key

## Getting a Google Maps API Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the following APIs:
   - Maps Static API
   - Geocoding API
4. Go to "Credentials" and create an API key
5. Restrict the API key to your app's bundle ID for security

## Setting Up the .env File

### Option 1: Using the provided scripts

**On Windows:**
```bash
create_env_file.bat
```

**On Unix-like systems (Linux/macOS):**
```bash
chmod +x create_env_file.sh
./create_env_file.sh
```

### Option 2: Manual creation

Create a file named `.env` in the root directory of your project with the following content:

```
GOOGLE_MAPS_API_KEY=your_actual_api_key_here
```

Replace `your_actual_api_key_here` with your actual Google Maps API key.

## Security Notes

- Never commit your `.env` file to version control
- The `.env` file is already included in `.gitignore`
- Keep your API key secure and restrict it to your app's bundle ID

## Testing

After setting up the API key, run your Flutter app. You should see:
- "✅ .env file loaded successfully" in the debug console
- Location features should work properly

If you see warnings about the API key not being found, double-check that:
1. The `.env` file exists in the project root
2. The API key is correctly formatted
3. The API key has the necessary permissions
