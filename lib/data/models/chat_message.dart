// No imports needed

enum MessageRole { user, ai }

class ChatMessage {
  final String text;
  final MessageRole role;
  final DateTime timestamp;
  final String? userName;

  ChatMessage({
    required this.text,
    required this.role,
    DateTime? timestamp,
    this.userName,
  }) : timestamp = timestamp ?? DateTime.now();
}
