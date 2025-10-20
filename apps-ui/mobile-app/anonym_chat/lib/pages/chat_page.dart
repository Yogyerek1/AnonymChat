import 'package:flutter/material.dart';
import 'package:anonym_chat/theme/app_colors.dart';
import '../models/message.dart';
import '../widgets/message_item.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> messages = [
    Message(
      senderId: 1,
      text: 'Szia!',
      isMyMessage: false,
      timestamp: DateTime.now(),
    ),
    Message(
      senderId: 2,
      text: 'Szia! Hogy vagy?',
      isMyMessage: true,
      timestamp: DateTime.now(),
    ),
    Message(
      senderId: 1,
      text: 'Jól vagyok!',
      isMyMessage: false,
      timestamp: DateTime.now(),
    ),
  ];
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        messages.add(
          Message(
            senderId: 2,
            text: _textController.text,
            isMyMessage: true,
            timestamp: DateTime.now(),
          ),
        );
      });
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '**Chat_Name**', // TODO: IDE JON MAJD A CHAT NEVE AMIT BEIR LETREHOZASNAL
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.title,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.content_copy))],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageItem(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Írj valamit...',
                      hintStyle: TextStyle(color: AppColors.primaryText),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: AppColors.title),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: AppColors.title,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send),
                  color: AppColors.title,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
