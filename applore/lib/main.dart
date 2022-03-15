import 'package:applore/ui/screens/login-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// Main App starts from here.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Applore Task',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
// Screen A is setted home for the application.
      home: const LoginScreen(),
    );
  }
}
