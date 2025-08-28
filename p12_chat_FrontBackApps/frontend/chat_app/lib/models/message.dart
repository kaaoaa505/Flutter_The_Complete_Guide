import 'user.dart';

class Message {
  final int? id;
  final User? user;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    this.id,
    this.user,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
