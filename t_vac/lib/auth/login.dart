import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/main_menu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                try {
                  _auth.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  // Navigate to main menu screen after successful login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenuScreen(),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('User not found. Please register.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } else if (e.code == 'wrong-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Wrong password. Please try again.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } else if (e.code == 'invalid-email') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid email address.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } else {
                    log('Error: ${e.message}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('An error occurred. Please try again later.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                } catch (e) {
                  log('Error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('An error occurred. Please try again later.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
