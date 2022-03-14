import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:applore/ui/login-screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false);
        },
        child: const Text(
          "Logout",
          style: TextStyle(color: Colors.white),
        ));
  }
}
