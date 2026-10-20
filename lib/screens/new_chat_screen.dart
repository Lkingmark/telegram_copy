import 'package:flutter/material.dart';

class NewChatScreen extends StatefulWidget{
  const NewChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _newChatScreen();
}
class _newChatScreen extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: Text("New chat"),
          ),
          body: TabBarView(
            children: [
              ListView(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: (){},
                      child: Text("Create new chat", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: (){},
                      child: Text("Create new channel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: (){},
                      child: Text("Create new group", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}