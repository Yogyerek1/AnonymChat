class Message {
  final String text;
  final DateTime timestamp;
  final bool isMyMessage;
  final String senderName;
  Message({
    required this.text,
    required this.isMyMessage,
    required this.timestamp,
    required this.senderName,
  });
}
