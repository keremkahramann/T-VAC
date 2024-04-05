// ignore_for_file: use_build_context_synchronously, unused_import

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
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
          child: Column(
            children: [
              Container(
                width: deviceWidth, // üst yeşil alanın genişliği
                height: deviceHeight / 3, // üst yeşil alanın uzunluğu
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                    Colors.green,
                    Color.fromARGB(255, 86, 231, 91),
                    Color.fromARGB(255, 96, 255, 101),
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage("lib/images/iconttvac.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(
                            10), // Köşeleri yuvarlatılmış beyaz alan
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // Shadow yönü: bottom-right
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'E-Posta',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'Şifre',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
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
                                    debugPrint("Login ERROR1:" '${e.code}');
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'Kullanıcı bulunamadı.Lütfen kayıt olunuz.'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else if (e.code == 'invalid-password' ||
                                      e.code == 'weak-password' ||
                                      e.code == 'invalid-credential') {
                                    debugPrint("Login ERROR2:" '${e.code}');
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'Şifre yanlış.Lütfen tekrar deneyiniz.'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else if (e.code == 'invalid-email') {
                                    debugPrint("Login ERROR3:" '${e.code}');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Geçerli bir E-posta adresi giriniz.'),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  } else if (e.code == 'channel-error') {
                                    debugPrint('Login Error4: ${e.code}');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'E-Posta veya şifre boş bırakılamaz.'),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  // debugPrint('Login Error5: ${e.code}');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'An error occurred. Please try again later.'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }

                                // Buton fonksiyonu buraya
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 85, 199, 89),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Giriş Yap'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 85, 199, 89),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Kayıt Ol'),
                            ),
                            TextButton(
                              onPressed: () {
                                showEmailDialog(context);
                              },
                              child: const Text(
                                'Şifremi Unuttum',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 85, 199, 89),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
