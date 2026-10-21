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

  Widget _sectionTitle(String title, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        title,
        style: TextStyle(
          color: colors.primary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _divider(ColorScheme colors, {double indent = 20}) {
    return Divider(
      height: 16,
      thickness: 0.5,
      indent: indent,
      endIndent: 20,
      color: colors.outlineVariant.withValues(alpha: 0.5),
    );
  }

  Widget _settingTile(
    ColorScheme colors,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      horizontalTitleGap: 16,
      leading: CircleAvatar(
        backgroundColor: colors.primaryContainer,
        child: Icon(icon, color: colors.onPrimaryContainer),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: colors.onSurfaceVariant.withValues(alpha: 0.8),
            height: 1.4,
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSettings(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _sectionTitle('Account', colors),
          _settingTile(
            colors,
            Icons.person_outline,
            'Account',
            'Profile, phone number and personal details',
            () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const SettingsScreenAccount(),
              ),
            ),
          ),
          _divider(colors),
          _sectionTitle('Security & Privacy', colors),
          _settingTile(
            colors,
            Icons.security_outlined,
            'Security',
            'Password and account protection',
            () {},
          ),
          _divider(colors, indent: 72),
          _settingTile(
            colors,
            Icons.lock_outline,
            'Privacy',
            'Control who can contact you',
            () {},
          ),
          _divider(colors),
          _sectionTitle('Notifications', colors),
          _settingTile(
            colors,
            Icons.notifications_outlined,
            'Notifications',
            'Notification preferences and exceptions',
            () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const SettingsScreenNotifications(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
