import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:t_vac/auth/firebase_options.dart';
import 'package:t_vac/screens/bluetooth.dart';
import 'package:t_vac/screens/deneme.dart';
import 'auth/login.dart' as login;
import 'auth/signup.dart' as signup;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/bluetooth',
      routes: {
        '/login': (context) => const login.LoginScreen(),
        '/signup': (context) => const signup.SignupScreen(),
        '/deneme': (context) => const deneme(),
        '/bluetooth': (context) => blue(),
      },
    );
  }
}
