import 'package:flutter/material.dart';
import 'settings_screen_notifications_exceptions.dart';


class SettingsScreenNotifications extends StatefulWidget {
  const SettingsScreenNotifications({super.key});

  @override
  State<SettingsScreenNotifications> createState() => _SettingsScreenNotificationsState();
}

class _SettingsScreenNotificationsState extends State<SettingsScreenNotifications> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              title: Text('Notifications'),
              subtitle: Text('Show or hide notifications'),
              trailing: Switch(
                value: _notificationsEnabled, onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      backgroundColor: Colors.lightBlue,
                      content: Center(
                        child: Text(
                          _notificationsEnabled
                              ? "Notifications turned on"
                              : "Notifications turned off",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute (
                    builder: (context) => const SettingsScreenNotificationsExceptions(),
                  ),
                );
              },
              child: ListTile(
                leading: const CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    child: Icon(Icons.edit_notifications, color: Colors.white, size: 25),
                ),
                title: Text('Notification exceptions'),
                subtitle: Text('Manage exceptions'),
              ),
            ),
          ),
        ]
      ),
    );
  }
}