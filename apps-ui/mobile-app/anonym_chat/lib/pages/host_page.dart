import 'package:flutter/material.dart';
import 'package:anonym_chat/theme/app_colors.dart';
import 'package:anonym_chat/services/chat_service.dart';
import 'package:anonym_chat/pages/chat_page.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  TextEditingController _chatNameController = TextEditingController();
  TextEditingController _chatPasswordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  final ChatService _chatService = ChatService();
  bool _isLoading = false;

  @override
  void dispose() {
    _chatNameController.dispose();
    _chatPasswordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    final chatName = _chatNameController.text.trim();
    final password = _chatPasswordController.text.trim();
    final userName = _userNameController.text.trim();

    if (chatName.isEmpty || password.isEmpty || userName.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Minden mezőt tölts ki')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final chat = await _chatService.createChat(
        chatName: chatName,
        password: password,
        userName: userName,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            chatCode: chat.id.toString(),
            chatPassword: chat.password,
            senderName: userName,
          ),
        ),
      );
    } catch (e) {
      print('HIBA: $e');
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
          'Létrehozás',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.title,
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
              controller: _chatNameController,
              style: TextStyle(color: AppColors.secondaryText),
              decoration: InputDecoration(
                labelText: 'Chat neve',
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
              onPressed: _isLoading ? null : _handleCreate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueBtn,
                foregroundColor: AppColors.btnText,
                fixedSize: Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.group_add, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Létrehozás',
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
