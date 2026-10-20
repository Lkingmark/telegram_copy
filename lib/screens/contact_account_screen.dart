import 'package:flutter/material.dart';

class ContactAccountScreen extends StatelessWidget {
const ContactAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.phone),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.message),
          ),
        ],
      ),
    );
  }
}