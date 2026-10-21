import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = switch (AppTheme.mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };
    return Theme(
      data: brightness == Brightness.dark ? AppTheme.dark : AppTheme.light,
      child: Builder(builder: _buildTest),
    );
  }

  Widget _buildTest(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Text(
            'Test1',
            style: TextStyle(
              color: colors.primary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Icon(Icons.mail, color: colors.tertiary, size: 100),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 10),
            color: colors.surfaceContainerLow,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: colors.onSurfaceVariant),
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
            position: const RelativeRect.fromLTRB(100, 500, 50, 0),
            items: [
              PopupMenuItem(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Test'),
                ),
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Wi-Fi'),
                    Switch(value: true, onChanged: (_) {}),
                  ],
                ),
              ),
              const PopupMenuItem(value: 3, child: Text('Пункт 3')),
              const CheckedPopupMenuItem(
                value: 1,
                checked: true,
                child: Text('Вибрано'),
              ),
              const PopupMenuItem(
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
        child: const Icon(Icons.more_vert),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
