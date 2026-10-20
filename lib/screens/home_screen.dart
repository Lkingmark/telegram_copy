import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';
import 'test_screen.dart';
import 'contacts_screen.dart';
import 'group_details_screen.dart';
import 'new_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  String _searchText = '';
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: _isSearching
              ? TextField(
            focusNode: _searchFocusNode,
            style: const TextStyle(color: Colors.white, fontSize: 22),
            decoration: const InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
          )
              : const Text('Telegram'),
        actions: [
          IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (_isSearching) {
                    _searchFocusNode.requestFocus();
                  }
                });
              },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('My Name'),
              accountEmail: Text('+380 99 123 45 67'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.grey),
              ),
              decoration: BoxDecoration(color: Colors.lightBlue),
            ),
            ListTile(
                leading: const Icon(Icons.group),
                title: const Text('New Chat'),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewChatScreen(),
                      ),
                  );
                },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: Text('Contacts'),
              onTap: (){
                Navigator.push(
                    context,
                  MaterialPageRoute(
                      builder: (context) => const ContactsScreen(),
                  ),
                );
              },
            ),
            ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
            ),
            ListTile(
              leading: const Icon(Icons.telegram),
              title: const Text('Test'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TestScreen (),
                    )
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.telegram),
              title: const Text('Group Details Screen'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroupDetailsScreen (),
                  ),
                );
                },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text('Chat ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Last message text...'),
            trailing: const Text('12:00'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.grey, width: 1),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(chatId: 'chat_$index', chatName: 'Chat ${index + 1}'),
                ),
              );
            },
            )
          );
        },
      ),
    );
  }
}