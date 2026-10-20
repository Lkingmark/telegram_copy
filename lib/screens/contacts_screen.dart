import 'package:flutter/material.dart';
import 'contact_account_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.lightBlue,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                      title: Text('Name Surname', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('+1234567890'),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.phone)),
                      ),
                    onPressed: (){
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
            onPressed: (){},
            backgroundColor: Colors.grey,
            child: PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                onSelected: (value){
                  if (value == "block_contact") {
                    _showChatBlockDialog(context);
                  };
                },
                itemBuilder: (context) => const[
                  PopupMenuItem(
                    value: "add_contact",
                    child: Row(
                      children: [
                        Icon(Icons.person_add, color: Colors.lightBlue),
                        SizedBox(width: 20),
                        Text('Add contact'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "remove_contact",
                    child: Row(
                      children: [
                        Icon(Icons.person_remove, color: Colors.lightBlue),
                        SizedBox(width: 20),
                        Text('Remove contact'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "block_contact",
                    child: Row(
                      children: [
                        Icon(Icons.person_off, color: Colors.lightBlue),
                        SizedBox(width: 20),
                        Text('Block contact'),
                      ],
                    ),
                  ),
              ]
            )
        )
      );
    }
    void _showChatBlockDialog(context){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text(
              "You will block this user"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                  "Cancel", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                  "Block", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
