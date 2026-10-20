import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        title: const Text('Test'),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10),
            const Text('Test1', style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Icon(Icons.mail, color: Colors.yellow, size: 100),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 10),
              color: Colors.brown,
              child: Row(
                children: [IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: () {},
                ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(100, 500, 50, 0),
              items: [
                PopupMenuItem(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Test'),
                  ),
                ),
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Wi-Fi'),
                      Switch(value: true, onChanged: (_) {}),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text('Пункт 3'),
                ),
                CheckedPopupMenuItem(
                  value: 1,
                  checked: true,
                  child: Text('Вибрано'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 10),
                      Text('Профіль'),
                    ],
                  ),
                ),
              ],
            );
          },
          child: Icon(Icons.more_vert),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
  }