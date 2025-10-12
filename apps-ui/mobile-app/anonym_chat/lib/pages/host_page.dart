import 'package:flutter/material.dart';
import 'package:anonym_chat/theme/app_colors.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  TextEditingController _chatNameController = TextEditingController();
  TextEditingController _chatPasswordController = TextEditingController();

  @override
  void dispose() {
    _chatNameController.dispose();
    _chatPasswordController.dispose();
    super.dispose();
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
            SizedBox(height: 100),
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
              onPressed: () {
                String name = _chatNameController.text;
                String password = _chatPasswordController.text;
                print('Chat neve: $name, Jelszó: $password');
                // TODO: API hívás
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueBtn,
                foregroundColor: AppColors.btnText,
                fixedSize: Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.group_add, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Létrehozás',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
