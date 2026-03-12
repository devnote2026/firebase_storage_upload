import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:go_router/go_router.dart';

import 'user_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final credential = await authService.signInWithGoogle();
            final uid = credential.user!.uid;
            debugPrint('ログインしたユーザー:$uid');

            final userService = UserService();
            final exists = await userService.userExists(uid);
            debugPrint('ユーザーが存在するか: $exists');

            if (!context.mounted) return;
            if (exists){
              context.go('/home');
            }else{
              context.go('/nickname_resister');
            }
          },
          child: const Text('Googleでサインインする'),
        ),
      ),
    );
  }
}