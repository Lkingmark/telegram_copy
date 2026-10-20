import 'package:flutter/material.dart';

class SettingsScreenAccount extends StatelessWidget {
  const SettingsScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: ListView(
      children: [
        ListTile(
          title: TextFormField(
            initialValue: 'Name',
            decoration: const
                InputDecoration(labelText: 'Name'),
          ),
        ),
        ListTile(
          title: TextFormField(
            initialValue: 'Surname',
            decoration: const
            InputDecoration(labelText: 'Surname'),
          ),
        ),
        ListTile(
          title: TextFormField(
          initialValue: 'Nickname',
          decoration: const
          InputDecoration(labelText: 'Nickname'),
          ),
        ),
        ListTile(
          title: TextFormField(
            initialValue: 'About me',
            decoration: const
            InputDecoration(labelText: 'About me'),
          ),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.lightBlue,
              child: Icon(Icons.cake, color: Colors.white)
          ),
          title: TextFormField(
            initialValue: '01/01/2000',
            keyboardType: TextInputType.datetime,
            decoration: const
                InputDecoration(
              labelText: 'Date of birth',
              hintText: 'DD/MM/YYYY',
            )
          ),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.lightBlue,
              child: Icon(Icons.phone, color: Colors.white)
          ),
          title: TextFormField(
            initialValue: '+380123456789',
            keyboardType: TextInputType.phone,
            decoration: const
                InputDecoration(labelText: 'Phone number',)
          ),
        ),
      ],
      )
    );
  }

}