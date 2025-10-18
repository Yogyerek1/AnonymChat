class Message {
  final String text;
  final DateTime timestamp;
  final bool isMyMessage;
  final int ownerId;
  Message(this.ownerId, this.text, this.isMyMessage, this.timestamp);
}
