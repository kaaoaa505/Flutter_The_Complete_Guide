import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/message.dart';

class ApiService {
  // Get the appropriate base URL based on the platform
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Android emulator uses 10.0.2.2 to access host machine's localhost
      return 'http://10.0.2.2:8000/api';
    } else {
      // Web, iOS simulator, and other platforms use localhost
      return 'http://localhost:8000/api';
    }
  }

  // Get all messages
  static Future<List<Message>> getMessages() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/messages'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> messagesJson = data['data'];
        return messagesJson.map((json) => Message.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Send a new message
  static Future<Message> sendMessage(String sender, String content) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/messages'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'sender': sender, 'content': content}),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Message.fromJson(data['data']);
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Update a message
  static Future<Message> updateMessage(
    int id,
    String sender,
    String content,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/messages/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'sender': sender, 'content': content}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Message.fromJson(data['data']);
      } else {
        throw Exception('Failed to update message');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Delete a message
  static Future<void> deleteMessage(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/messages/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete message');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
