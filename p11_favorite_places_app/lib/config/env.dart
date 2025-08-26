import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Load .env file using flutter_dotenv
      await dotenv.load(fileName: ".env");
      debugPrint('✅ Environment variables loaded from .env file');
      debugPrint('📋 Available variables: ${dotenv.env.keys.join(', ')}');
      _initialized = true;
    } catch (e) {
      debugPrint('⚠️ Error loading environment variables: $e');
      debugPrint(
          '📝 Please create a .env file with GOOGLE_MAPS_API_KEY=your_key');
      _initialized = true;
    }
  }

  static String get googleMapsApiKey {
    if (!_initialized) {
      throw StateError(
          'Environment not initialized. Call Env.initialize() first.');
    }
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    if (apiKey.isNotEmpty) {
      debugPrint('✅ Successfully loaded Google Maps API key');
    } else {
      debugPrint(
          '! Warning: GOOGLE_MAPS_API_KEY not found in environment variables');
      debugPrint('🔍 Available keys: ${dotenv.env.keys.join(', ')}');
    }
    return apiKey;
  }

  static bool get isApiKeyAvailable => googleMapsApiKey.isNotEmpty;
}
