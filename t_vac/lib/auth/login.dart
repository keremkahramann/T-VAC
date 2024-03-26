// ignore_for_file: use_build_context_synchronously, unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_vac/auth/authWidgets/reset_password.dart';
import '../screens/main_menu.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    // container için genişlik ve uzunluk aldım cihazın uzunluğuna sabit olucak bunlar
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      Container(
        width: deviceWidth, // üst yeşil alanın genişliği
        height: deviceHeight / 4, // üst yeşil alanın uzunluğu
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 127, 198, 47),
            image: DecorationImage(
                image: AssetImage("lib/images/bugday1.png"),
                fit: BoxFit.contain)),
      ),
      const Padding(
          padding: EdgeInsets.only(top: 30, right: 150),
          child: Text(
            "Hoşgeldiniz",
            style: TextStyle(
                color: Color.fromARGB(255, 118, 192, 33),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          )),
      Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'E-Posta',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 118, 192, 33)))),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: 'Şifre',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 118, 192, 33)))),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await _auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    // Navigate to main menu screen after successful login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Kullanıcı bulunamadı.Lütfen kayıt olunuz.'),
                        duration: Duration(seconds: 3),
                      ));
                    } else if (e.code == 'wrong-password' ||
                        passwordController.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Şifre yanlış.Lütfen tekrar deneyiniz.'),
                        duration: Duration(seconds: 3),
                      ));
                    } else if (e.code == 'invalid-email' ||
                        e.email == null ||
                        e.email == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Geçerli bir E-posta adresi giriniz.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      log('Error: ${e.message}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'An error occurred. Please try again later.'),
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
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 118, 192, 33),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Giriş Yap')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 118, 192, 33),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Kayıt Ol')),
            TextButton(
                onPressed: () {
                  showEmailDialog(context);
                },
                child: const Text(
                  'Şifremi Unuttum',
                  style: TextStyle(
                    color: Color.fromARGB(255, 118, 192, 33),
                  ),
                ))
          ],
        ),
      ),
    ]))));
  }
}
