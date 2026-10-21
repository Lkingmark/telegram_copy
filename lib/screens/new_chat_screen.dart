import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _newChatScreen();
}

class _newChatScreen extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final brightness = switch (AppTheme.mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };
    return Theme(
      data: brightness == Brightness.dark ? AppTheme.dark : AppTheme.light,
      child: Builder(builder: _buildNewChat),
    );
  }

  Widget _buildNewChat(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text("New chat")),
        body: TabBarView(
          children: [
            ListView(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.surfaceContainerLow,
                    foregroundColor: colors.primary,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Create new chat",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.surfaceContainerLow,
                    foregroundColor: colors.primary,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Create new channel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.surfaceContainerLow,
                    foregroundColor: colors.primary,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Create new group",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
