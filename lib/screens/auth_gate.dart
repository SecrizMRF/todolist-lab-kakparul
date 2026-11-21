import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pertemuan6/screens/sign_in_screen.dart';
import '../services/auth_service.dart';
import 'profile_screen.dart';
import 'todo_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return StreamBuilder<User?>(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Terjadi kesalahan.')),
          );
        } else if (snapshot.hasData) {
          return TodoScreen();
        } else {
          return SignInScreen();
        }
      },
    );
  }
}