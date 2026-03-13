import 'message.dart';

class Chat {
  final String id;
  final String ownerName;
  final String name;
  final String password;
  final List<Message>? messages;
  Chat({
    required this.id,
    required this.ownerName,
    required this.name,
    required this.password,
    required this.messages,
  });
}
