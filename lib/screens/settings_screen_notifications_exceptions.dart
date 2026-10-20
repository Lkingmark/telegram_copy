import 'package:flutter/material.dart';


class SettingsScreenNotificationsExceptions extends StatelessWidget {
  const SettingsScreenNotificationsExceptions({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Notification exceptions'),
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
           child: ElevatedButton(
             style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.white,
                 padding: EdgeInsets.zero,
             ),
             onPressed: () {},
               child: ListTile(
                 leading: CircleAvatar(
                   backgroundColor: Colors.lightBlue,
                   child: Icon(
                       Icons.chat_sharp,
                       color: Colors.white,
                       size: 25,
                   ),
                 ),
                 title: Text('All chats'),
                 subtitle: Text('Manage all chats'),
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
             onPressed: (){},
             child: ListTile(
               leading: CircleAvatar(
                 backgroundColor: Colors.lightBlue,
                 child: Icon(
                     Icons.wechat_outlined,
                     color: Colors.white,
                     size: 25,
                 ),
               ),
               title: Text('Chats'),
               subtitle: Text('Manage only chats'),
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
             onPressed: (){},
             child: ListTile(
               leading: CircleAvatar(
                 backgroundColor: Colors.lightBlue,
                 child: Icon(
                   Icons.group,
                   color: Colors.white,
                   size: 25,
                 ),
               ),
               title: Text('Groups'),
               subtitle: Text('Manage only groups'),
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
             onPressed: (){},
             child: ListTile(
               leading: CircleAvatar(
                 backgroundColor: Colors.lightBlue,
                 child: Icon(
                   Icons.newspaper,
                   color: Colors.white,
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