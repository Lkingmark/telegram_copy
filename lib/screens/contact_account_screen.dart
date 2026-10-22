import 'package:flutter/material.dart';

class ContactAccountScreen extends StatelessWidget {
  const ContactAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
        ],
      ),
    );
  }
}
