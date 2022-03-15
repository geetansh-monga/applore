import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:applore/firebase/sign_in_using_email.dart';
import 'package:applore/ui/screens/products-screen.dart';
import 'package:applore/ui/widgets/login_textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuthentication _firebaseAuthentication =
      FirebaseAuthentication();

  bool _showPassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Login/Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginTextField(
              readOnly: _isLoading,
              hintText: 'Email',
              isRequired: true,
              textEditingController: _emailController,
            ),
            const SizedBox(
              height: 25,
            ),
            LoginTextField(
              readOnly: _isLoading,
              hintText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(_showPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
              obscureText: _showPassword,
              textEditingController: _passwordController,
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                UserCredential? _userCredential = await _firebaseAuthentication
                    .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text)
                    .onError((error, stackTrace) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                  return null;
                });
                setState(() {
                  _isLoading = false;
                });
                if (_userCredential != null) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const ProductsScreen()),
                      (route) => false);
                }
              },
              child: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
