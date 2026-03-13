import 'package:flutter/material.dart';
import 'package:anonym_chat/theme/app_colors.dart';
import 'package:flutter/services.dart';
import '../models/message.dart';
import '../widgets/message_item.dart';
import 'package:anonym_chat/models/chat.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late List<Message> messages = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState(){
    super.initState();
    messages = widget.chat.messages ?? [];
  }

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
            senderId: widget.chat.owner.id,
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
        title: Text(
          widget.chat.name, // TODO: IDE JON MAJD A CHAT NEVE AMIT BEIR LETREHOZASNAL
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.title,
        actions: [IconButton(onPressed: () {
          Clipboard.setData(ClipboardData(text: widget.chat.id.toString()),);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chat kód másolva: ${widget.chat.id}')),);
        }, icon: Icon(Icons.content_copy))],
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
