//最終的にだとりつく画面
//ログアウト機能を持つ

import 'package:flutter/material.dart';
import '../auth/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authService.signOut();
          },
          child: const Text('ログアウト'),
        ),
      ),
    );
  }
}