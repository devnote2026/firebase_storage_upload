import 'package:flutter/material.dart';

class NicknameResisterScreen extends StatefulWidget {
  const NicknameResisterScreen({super.key});

  @override
  State<NicknameResisterScreen> createState() => _NicknameResisterScreenState();
}

class _NicknameResisterScreenState extends State<NicknameResisterScreen> {

  final nicknameController = TextEditingController();

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
              onPressed: () {
                debugPrint (nicknameController.text);
              },
              child: const Text("登録"),
            )

          ],
        ),
      ),
    );
  }
}