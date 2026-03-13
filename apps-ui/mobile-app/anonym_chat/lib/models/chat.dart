import 'message.dart';
import 'user.dart';

class Chat {
  final int id;
  final User ownerName;
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
