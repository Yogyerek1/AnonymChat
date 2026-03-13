import 'message.dart';
import 'user.dart';

class Chat {
  final int id;
  final User owner;
  final String name;
  final String password;
  final List<Message>? messages;
  Chat({
    required this.id,
    required this.owner,
    required this.name,
    required this.password,
    required this.messages,
  });
}

final defaultChat = Chat(
  id: 0,
  owner: User(id: 1, name: "Dominik"),
  name: "Dev Chat",
  password: "dev",
  messages: [],
);
