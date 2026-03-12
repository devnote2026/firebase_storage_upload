import 'package:flutter/material.dart';
import 'user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class NicknameResisterScreen extends StatefulWidget {
  const NicknameResisterScreen({super.key});

  @override
  State<NicknameResisterScreen> createState() => _NicknameResisterScreenState();
}

class _NicknameResisterScreenState extends State<NicknameResisterScreen> {

  final nicknameController = TextEditingController();
  final userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ニックネーム登録"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: nicknameController,
              decoration: const InputDecoration(
                labelText: "ニックネーム",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async{
                debugPrint (nicknameController.text);
                final nickname = nicknameController.text.trim();

                final uid = FirebaseAuth.instance.currentUser!.uid;

                await userService.createUser(nickname : nickname, uid: uid);
                context.go('/home');
              },
              child: const Text("登録"),
            )

          ],
        ),
      ),
    );
  }
}