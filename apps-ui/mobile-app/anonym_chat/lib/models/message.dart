class Message {
  final String text;
  final DateTime timestamp;
  final bool isMyMessage;
  final int senderId;
  Message({
    required this.senderId,
    required this.text,
    required this.isMyMessage,
    required this.timestamp,
  });
}
