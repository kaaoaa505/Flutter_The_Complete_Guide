import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../services/api_service.dart';

class ChatProvider with ChangeNotifier {
  List<Message> _messages = [];
  bool _isLoading = false;
  String _error = '';

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Load all messages
  Future<void> loadMessages() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _messages = await ApiService.getMessages();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Send a new message
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    try {
      final newMessage = await ApiService.sendMessage(content);
      _messages.add(newMessage);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Update a message
  Future<void> updateMessage(int id, String content) async {
    try {
      final updatedMessage = await ApiService.updateMessage(id, content);
      final index = _messages.indexWhere((message) => message.id == id);
      if (index != -1) {
        _messages[index] = updatedMessage;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Delete a message
  Future<void> deleteMessage(int id) async {
    try {
      await ApiService.deleteMessage(id);
      _messages.removeWhere((message) => message.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = '';
    notifyListeners();
  }
}
