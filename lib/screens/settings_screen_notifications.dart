import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'settings_screen_notifications_exceptions.dart';

class SettingsScreenNotifications extends StatefulWidget {
  const SettingsScreenNotifications({super.key});

  @override
  State<SettingsScreenNotifications> createState() =>
      _SettingsScreenNotificationsState();
}

class _SettingsScreenNotificationsState
    extends State<SettingsScreenNotifications> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    );
    final cardDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: colors.cardShadow,
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(32),
    );
    final subtitleStyle = TextStyle(color: colors.secondaryText);
    const tilePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 4);
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            decoration: cardDecoration,
            child: ListTile(
              contentPadding: tilePadding,
              horizontalTitleGap: 16,
              subtitleTextStyle: subtitleStyle,
              leading: CircleAvatar(
                backgroundColor: colors.primaryContainer,
                child: Icon(
                  Icons.notifications,
                  color: colors.onPrimaryContainer,
                ),
              ),
              title: const Text('Notifications'),
              subtitle: Text(
                _notificationsEnabled
                    ? 'Notifications turned on'
                    : 'Notifications turned off',
              ),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: cardDecoration,
            child: Material(
              color: AppTheme.transparent,
              shape: cardShape,
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: tilePadding,
                horizontalTitleGap: 16,
                subtitleTextStyle: subtitleStyle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SettingsScreenNotificationsExceptions(),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: colors.primaryContainer,
                  child: Icon(
                    Icons.edit_notifications,
                    color: colors.onPrimaryContainer,
                    size: 25,
                  ),
                ),
                title: const Text('Notification exceptions'),
                subtitle: const Text('Manage exceptions'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
