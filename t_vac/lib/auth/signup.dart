// ignore_for_file: avoid_print, use_build_context_synchronously

// import 'dart:developer';
// import 'dart:math';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-Posta',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Şifre',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                  Navigator.pushReplacementNamed(context, '/login');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'invalid-email' ||
                      e.email == null ||
                      e.email == "") {
                    if (e.code == 'weak-password') {
                      debugPrint("SignUpError: " '${e.code}');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Şifreniz en az 6 karakter olmalıdır."),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      debugPrint("SignUpError: " '${e.code}');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Geçerli bir E-posta adresi giriniz."),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 85, 199, 89),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Kayıt Ol',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
