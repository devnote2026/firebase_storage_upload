import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';
import 'features/auth/nickname_resister_screen.dart';

class AppRouter {
  static final _authNotifier =
      AuthStateNotifier(FirebaseAuth.instance.authStateChanges());

  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    refreshListenable: _authNotifier,
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final isLogin = state.matchedLocation == '/login';

      if (user == null) {
        return isLogin ? null : '/login';
      }

      if (isLogin) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "/nickname_resister",
        builder: (context, state) => const NicknameResisterScreen(),
),
    ],
  );
}

class AuthStateNotifier extends ChangeNotifier {
  AuthStateNotifier(Stream<User?> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<User?> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}