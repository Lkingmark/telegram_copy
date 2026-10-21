import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'settings_screen_account.dart';
import 'settings_screen_notifications.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = switch (AppTheme.mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };
    return Theme(
      data: brightness == Brightness.dark ? AppTheme.dark : AppTheme.light,
      child: Builder(builder: _buildSettings),
    );
  }

  Widget _buildSettings(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const Divider(height: 1, indent: 40),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: colors.primaryContainer,
              child: Icon(Icons.person, color: colors.onPrimaryContainer),
            ),
            title: const Text('Account'),
            subtitle: const Text('Manage your account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreenAccount(),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: colors.primaryContainer,
              child: Icon(Icons.security, color: colors.onPrimaryContainer),
            ),
            title: const Text('Security'),
            onTap: () {},
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: colors.primaryContainer,
              child: Icon(
                Icons.notifications,
                color: colors.onPrimaryContainer,
              ),
            ),
            title: const Text('Notifications'),
            subtitle: const Text('Manage your account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreenNotifications(),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: colors.primaryContainer,
              child: Icon(Icons.lock, color: colors.onPrimaryContainer),
            ),
            title: const Text('Privacy'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
