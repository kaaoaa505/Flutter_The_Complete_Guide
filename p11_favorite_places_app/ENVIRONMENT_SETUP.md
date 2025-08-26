# Environment Variable Setup

## Overview

This project uses `flutter_dotenv` for reliable environment variable management in Flutter apps.

## What Changed

### Removed

- Custom environment variable loading code
- Complex path resolution logic
- Manual file parsing

### Added

- `flutter_dotenv` package dependency
- Simple and reliable environment variable loading
- Standard Flutter asset-based approach

## How It Works

### 1. Environment Initialization

The environment is initialized in `main.dart`:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.initialize(); // Load environment variables using flutter_dotenv
  runApp(const ProviderScope(child: MyApp()));
}
```

### 2. Environment Configuration

Create a `.env` file in the project root:

```
GOOGLE_MAPS_API_KEY=your_actual_api_key_here
```

**Important**: The `.env` file is included in the `assets` section of `pubspec.yaml` so `flutter_dotenv` can access it.

### 3. Using Environment Variables

Access environment variables in your code:

```dart
import 'package:p11_favorite_places_app/config/env.dart';

// Get the API key
String apiKey = Env.googleMapsApiKey;

// Check if API key is available
if (Env.isApiKeyAvailable) {
  // Use the API key
}
```

## Benefits

1. **Reliable**: Uses Flutter's asset system for file access
2. **Standard**: Industry-standard approach used by many Flutter apps
3. **Simple**: No complex path resolution or file parsing
4. **Well-tested**: `flutter_dotenv` is a mature, well-maintained package
5. **Cross-platform**: Works consistently across all platforms

## Getting a Google Maps API Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the following APIs:
   - Maps Static API
   - Geocoding API
4. Go to "Credentials" and create an API key
5. Add the API key to your `.env` file

## Security Notes

- The `.env` file is already included in `.gitignore`
- Never commit your actual API keys to version control
- Keep your API key secure and restrict it to your app's bundle ID

## Testing

After setting up the API key, run your Flutter app. You should see:

- "✅ Environment variables loaded from .env file" in the debug console
- "✅ Successfully loaded Google Maps API key"
- Location features should work properly

If you see warnings about the API key not being found, double-check that:

1. The `.env` file exists in the project root
2. The API key is correctly formatted
3. The API key has the necessary permissions
4. You've run `flutter pub get` after adding the dependency
