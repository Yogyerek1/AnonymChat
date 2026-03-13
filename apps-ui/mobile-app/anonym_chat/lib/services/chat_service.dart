import 'dart:convert';

import 'package:anonym_chat/models/chat.dart';
import 'package:anonym_chat/models/message.dart';
import 'package:anonym_chat/models/user.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final String baseUrl = 'http://192.168.11.198:3000/chats';

  Future<Chat> createChat({
    required String chatName,
    required String password,
    required String userName,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': chatName,
        'password': password,
        'ownerName': userName,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Chat(
        id: data['id'],
        ownerName: data['ownerName'],
        name: data['name'],
        password: password,
        messages: [],
      );
    } else {
      throw Exception('Failed to create chat!');
    }
  }

  Future<bool> joinChat({
    required String code,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/join'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['approved'] == true;
    }
    return false;
  }

  Future<List<Message>> getMessages({
    required String code,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code, 'password': password}),
    );

    if (response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map(
            (m) => Message(
              senderId: 0,
              text: m['content'],
              senderName: m['senderName'],
              isMyMessage: false,
              timestamp: DateTime.parse(m['createdAt']),
            ),
          )
          .toList();
    }
    return [];
  }

  Future<void> sendMessage({
    required String code,
    required String password,
    required String content,
    required String senderName,
  }) async {
    await http.post(
      Uri.parse('$baseUrl/message'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'code': code,
        'password': password,
        'content': content,
        'senderName': senderName,
      }),
    );
  }
}
