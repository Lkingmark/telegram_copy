import 'package:flutter/material.dart';
import 'settings_screen_account.dart';
import 'settings_screen_notifications.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            const Divider(height: 1,indent: 40,),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text('Account'),
              subtitle: Text('Manage your account'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreenAccount(),
                    )
                );
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Icon(Icons.security, color: Colors.white),
              ),
              title: Text('Security'),
              onTap: () {},
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              title: Text('Notifications'),
              subtitle: Text('Manage your account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute (
                      builder: (context) => const SettingsScreenNotifications(),
                  )
                );
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Icon(Icons.lock, color: Colors.white),
              ),
              title: Text('Privacy'),
              onTap: () {},
            ),
          ]
        ),
    );
  }
}