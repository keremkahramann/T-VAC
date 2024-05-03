import 'package:flutter/material.dart';

class SchoolPage extends StatelessWidget {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text('School'),
      ),
      body: const Center(
        child: Text('Welcome to the School Page!'),
      ),
    );
  }
}
