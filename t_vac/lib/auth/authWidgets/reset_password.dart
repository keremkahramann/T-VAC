import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showEmailDialog(BuildContext context) {
  final TextEditingController emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(child: Text('Şifre Sıfırlama')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('E-posta adresinizi girin:'),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'E-posta',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 118, 192, 33)))),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'İptal',
              style: TextStyle(color: Color.fromARGB(255, 118, 192, 33)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final String email = emailController.text.trim();

              if (email.isEmpty) {
                return;
              }

              try {
                FirebaseAuth.instance.sendPasswordResetEmail(email: email);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Şifre sıfırlama e-postası gönderildi.'),
                  ),
                );

                Navigator.of(context).pop();
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.message!),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 118, 192, 33),
                foregroundColor: Colors.white),
            child: const Text('Şifreyi Sıfırla'),
          ),
        ],
      );
    },
  );
}
