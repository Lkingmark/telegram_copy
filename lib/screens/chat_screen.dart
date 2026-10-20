import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String chatName;

  const ChatScreen({super.key, required this.chatId, required this.chatName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, text);
      });
      _messageController.clear();
      // Тут буде виклик методу відправки через WebSocket
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _showChatDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text(
              "You will no longer be able to read new messages!"),
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
                  "Delete", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
  void _showChatPinDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("This chat will appear at the top, above all other chats"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Pin", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
  void _showChatBlockDialog(){
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5DDD5),
      appBar: AppBar(
        title: Text(widget.chatName),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == "delete") _showChatDeleteDialog();
              if (value == "push_pin") _showChatPinDialog();
              if (value == "block") _showChatBlockDialog();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "push_pin",
                child: Row(
                  children: [
                    Text("Pin chat"),
                  ],
                ),
              ),
              const PopupMenuItem(
                  value: "block",
                  child: Row(
                    children: [
                      Text("Block user"),
                    ],
                  ),
              ),
              const PopupMenuItem(
                value: "delete",
                child: Row(
                  children: [
                    Text("Delete chat", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1FFC7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      _messages[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.lightBlue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}