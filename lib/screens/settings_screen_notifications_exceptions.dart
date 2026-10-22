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
    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    );
    final cardDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: colors.shadow.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(32),
    );
    final subtitleStyle = TextStyle(
      color: colors.onSurfaceVariant.withValues(alpha: 0.8),
    );
    const tilePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 4);
    return Scaffold(
      appBar: AppBar(title: const Text('Notification exceptions')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            decoration: cardDecoration,
            child: Material(
              color: Colors.transparent,
              shape: cardShape,
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: tilePadding,
                horizontalTitleGap: 16,
                subtitleTextStyle: subtitleStyle,
                onTap: () {},
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
          const SizedBox(height: 12),
          Container(
            decoration: cardDecoration,
            child: Material(
              color: Colors.transparent,
              shape: cardShape,
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: tilePadding,
                horizontalTitleGap: 16,
                subtitleTextStyle: subtitleStyle,
                onTap: () {},
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
          const SizedBox(height: 12),
          Container(
            decoration: cardDecoration,
            child: Material(
              color: Colors.transparent,
              shape: cardShape,
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: tilePadding,
                horizontalTitleGap: 16,
                subtitleTextStyle: subtitleStyle,
                onTap: () {},
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
          const SizedBox(height: 12),
          Container(
            decoration: cardDecoration,
            child: Material(
              color: Colors.transparent,
              shape: cardShape,
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: tilePadding,
                horizontalTitleGap: 16,
                subtitleTextStyle: subtitleStyle,
                onTap: () {},
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
