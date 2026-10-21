import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreenAccount extends StatelessWidget {
  const SettingsScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = switch (AppTheme.mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };
    return Theme(
      data: brightness == Brightness.dark ? AppTheme.dark : AppTheme.light,
      child: Builder(builder: _buildAccount),
    );
  }

  Widget _buildAccount(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: ListView(
        children: [
          ListTile(
            title: TextFormField(
              initialValue: 'Name',
              decoration: const InputDecoration(labelText: 'Name'),
            ),
          ),
          ListTile(
            title: TextFormField(
              initialValue: 'Surname',
              decoration: const InputDecoration(labelText: 'Surname'),
            ),
          ),
          ListTile(
            title: TextFormField(
              initialValue: 'Nickname',
              decoration: const InputDecoration(labelText: 'Nickname'),
            ),
          ),
          ListTile(
            title: TextFormField(
              initialValue: 'About me',
              decoration: const InputDecoration(labelText: 'About me'),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: colors.primaryContainer,
              child: Icon(Icons.cake, color: colors.onPrimaryContainer),
            ),
            title: TextFormField(
              initialValue: '01/01/2000',
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: 'Date of birth',
                hintText: 'DD/MM/YYYY',
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: colors.primaryContainer,
              child: Icon(Icons.phone, color: colors.onPrimaryContainer),
            ),
            title: TextFormField(
              initialValue: '+380123456789',
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone number'),
            ),
          ),
        ],
      ),
    );
  }
}
