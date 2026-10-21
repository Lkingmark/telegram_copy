import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'contact_account_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final brightness = switch (AppTheme.mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };
    return Theme(
      data: brightness == Brightness.dark ? AppTheme.dark : AppTheme.light,
      child: Builder(builder: _buildContacts),
    );
  }

  Widget _buildContacts(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colors.primaryContainer,
                        child: Icon(
                          Icons.person,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      title: Text(
                        'Name Surname',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('+1234567890'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.phone),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactAccountScreen(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            if (value == "block_contact") {
              _showChatBlockDialog(context);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "add_contact",
              child: Row(
                children: [
                  Icon(Icons.person_add, color: colors.primary),
                  const SizedBox(width: 20),
                  const Text('Add contact'),
                ],
              ),
            ),
            PopupMenuItem(
              value: "remove_contact",
              child: Row(
                children: [
                  Icon(Icons.person_remove, color: colors.primary),
                  const SizedBox(width: 20),
                  const Text('Remove contact'),
                ],
              ),
            ),
            PopupMenuItem(
              value: "block_contact",
              child: Row(
                children: [
                  Icon(Icons.person_off, color: colors.primary),
                  const SizedBox(width: 20),
                  const Text('Block contact'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChatBlockDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final colors = Theme.of(context).colorScheme;
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("You will block this user"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.error,
                foregroundColor: colors.onError,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Block"),
            ),
          ],
        );
      },
    );
  }
}
