import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TelegramApp());
}

class TelegramApp extends StatelessWidget {
  const TelegramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFF2CA5E0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2CA5E0),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}