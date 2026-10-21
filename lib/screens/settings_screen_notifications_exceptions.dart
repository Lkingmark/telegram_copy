import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreenNotificationsExceptions extends StatelessWidget {
  const SettingsScreenNotificationsExceptions({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = switch (AppTheme.mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };
    return Theme(
      data: brightness == Brightness.dark ? AppTheme.dark : AppTheme.light,
      child: Builder(builder: _buildExceptions),
    );
  }

  Widget _buildExceptions(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Notification exceptions')),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.surfaceContainerLow,
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colors.primaryContainer,
                  child: Icon(
                    Icons.chat_sharp,
                    color: colors.onPrimaryContainer,
                    size: 25,
                  ),
                ),
                title: Text('All chats'),
                subtitle: Text('Manage all chats'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.surfaceContainerLow,
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colors.primaryContainer,
                  child: Icon(
                    Icons.wechat_outlined,
                    color: colors.onPrimaryContainer,
                    size: 25,
                  ),
                ),
                title: Text('Chats'),
                subtitle: Text('Manage only chats'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.surfaceContainerLow,
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colors.primaryContainer,
                  child: Icon(
                    Icons.group,
                    color: colors.onPrimaryContainer,
                    size: 25,
                  ),
                ),
                title: Text('Groups'),
                subtitle: Text('Manage only groups'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.surfaceContainerLow,
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colors.primaryContainer,
                  child: Icon(
                    Icons.newspaper,
                    color: colors.onPrimaryContainer,
                    size: 25,
                  ),
                ),
                title: Text('Channels'),
                subtitle: Text('Manage only channels'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
