import 'package:anonym_chat/models/chat.dart';
import 'package:anonym_chat/models/message.dart';
import 'package:anonym_chat/models/user.dart';

class ChatService {

  final List<Chat> _chats = [
    Chat(id: 0, owner: User(id: 1, name: "Dominik"), name: "Dev Chat", password: "dev", messages: []),
  ];

  late int _chatIdCounter = _chats.length;

  Chat createChat({required String chatName, required password, required userName}){
    final newChat = Chat(id: _chatIdCounter, owner: User(id: _chatIdCounter, name: userName), name: chatName, password: password, messages: []);
    _chats.add(newChat);
    _chatIdCounter++;
    return newChat;
  }

  Chat? findChatById(int id){
    try{
      return _chats.firstWhere((chat) => chat.id == id);
    }catch (e) {
      print("Chat Not Found With This ID!");
      return null;
    }
  }

  void addMessageToChat(int chatId, Message message){
    final chat = findChatById(chatId);
    if(chat != null){
      chat.messages?.add(message);
    }
  }
}