import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Load .env file using flutter_dotenv
      await dotenv.load(fileName: ".env");
      _initialized = true;
    } catch (e) {
      // Error loading environment variables
      _initialized = true;
    }
  }

  static String get googleMapsApiKey {
    if (!_initialized) {
      // Return empty string instead of throwing error to prevent crashes
      return '';
    }
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    return apiKey;
  }

  static bool get isApiKeyAvailable => googleMapsApiKey.isNotEmpty;
}
