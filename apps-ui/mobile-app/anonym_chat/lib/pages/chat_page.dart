import 'dart:async';

import 'package:anonym_chat/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:anonym_chat/theme/app_colors.dart';
import 'package:flutter/services.dart';
import '../models/message.dart';
import '../widgets/message_item.dart';
import 'package:anonym_chat/models/chat.dart';

class ChatPage extends StatefulWidget {
  final String chatCode;
  final String chatPassword;
  final String senderName;
  final String chatName;

  const ChatPage({
    super.key,
    required this.chatCode,
    required this.chatPassword,
    required this.senderName,
    required this.chatName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();

  List<Message> _messages = [];
  Timer? _pollingTimer;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _loadMessages();
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await _chatService.getMessages(
        code: widget.chatCode,
        password: widget.chatPassword,
      );

      if (!mounted) return;

      setState(() {
        _messages = messages
            .map(
              (m) => Message(
                text: m.text,
                senderName: m.senderName,
                isMyMessage: m.senderName == widget.senderName,
                timestamp: m.timestamp,
              ),
            )
            .toList();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      });
    } catch (e) {}
  }

  Future<void> _sendMessage() async {
    if (_textController.text.trim().isEmpty || _isSending) return;

    final content = _textController.text.trim();
    _textController.clear();
    setState(() => _isSending = true);

    try {
      await _chatService.sendMessage(
        code: widget.chatCode,
        password: widget.chatPassword,
        content: content,
        senderName: widget.senderName,
      );

      await _loadMessages();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Üzenet küldése sikertelen!')),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.chatName,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.title,
        actions: [
          IconButton(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: widget.chatCode.toString()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Chat kód másolva: ${widget.chatCode}')),
              );
            },
            icon: Icon(Icons.content_copy),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageItem(message: _messages[index]);
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
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background,
                      hintText: 'Írj valamit...',
                      hintStyle: TextStyle(color: AppColors.primaryText),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
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
                  onPressed: _isSending ? null : _sendMessage,
                  icon: _isSending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(Icons.send),
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
