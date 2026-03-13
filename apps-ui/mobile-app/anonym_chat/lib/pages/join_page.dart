import 'dart:convert';

import 'package:anonym_chat/models/chat.dart';
import 'package:anonym_chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:anonym_chat/theme/app_colors.dart';
import 'package:anonym_chat/services/chat_service.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _chatCodeController = TextEditingController();
  final TextEditingController _chatPasswordController = TextEditingController();
  final ChatService _chatService = ChatService();
  bool _isLoading = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _chatCodeController.dispose();
    _chatPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleJoin() async {
    final code = _chatCodeController.text.trim();
    final name = _userNameController.text.trim();
    final password = _chatPasswordController.text.trim();

    if (code.isEmpty || name.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Minden mezőt tölts ki!')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final approved = await _chatService.joinChat(
        code: code,
        password: password,
      );

      if (!mounted) return;

      if (approved) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              chatCode: code,
              chatPassword: password,
              senderName: name,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Hibás kód vagy jelszó!')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hiba történt, próbáld újra!')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Csatlakozás',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.greenBtn,
          ),
        ),
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.greenBtn,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            TextField(
              controller: _userNameController,
              style: TextStyle(color: AppColors.secondaryText),
              decoration: InputDecoration(
                labelText: 'Neved',
                hintText: 'Név...',
                hintStyle: TextStyle(
                  color: AppColors.secondaryText.withOpacity(0.5),
                ),
                labelStyle: TextStyle(color: AppColors.secondaryText),
                filled: true,
                fillColor: AppColors.background,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.secondaryText,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.blueBtn, width: 2),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _chatCodeController,
              style: TextStyle(color: AppColors.secondaryText),
              decoration: InputDecoration(
                labelText: 'Chat Kód',
                hintText: 'Kód...',
                hintStyle: TextStyle(
                  color: AppColors.secondaryText.withOpacity(0.5),
                ),
                labelStyle: TextStyle(color: AppColors.secondaryText),
                filled: true,
                fillColor: AppColors.background,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.secondaryText,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.blueBtn, width: 2),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _chatPasswordController,
              obscureText: true, // Jelszó elrejtése
              style: TextStyle(color: AppColors.secondaryText),
              decoration: InputDecoration(
                labelText: 'Jelszó',
                hintText: 'Jelszó...',
                hintStyle: TextStyle(
                  color: AppColors.secondaryText.withOpacity(0.5),
                ),
                labelStyle: TextStyle(color: AppColors.secondaryText),
                filled: true,
                fillColor: AppColors.background,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.secondaryText,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.blueBtn, width: 2),
                ),
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleJoin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenBtn,
                foregroundColor: AppColors.btnText,
                fixedSize: Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.group_add, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Belépés',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
