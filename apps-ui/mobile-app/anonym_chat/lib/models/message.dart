class Message {
  final String text;
  final DateTime timestamp;
  final bool isMyMessage;
  final int senderId;
  final String senderName;
  Message({
    required this.senderId,
    required this.text,
    required this.isMyMessage,
    required this.timestamp,
    required this.senderName,
  });
}
