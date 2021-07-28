import 'package:chat_app/widgets/message.dart';
import 'package:chat_app/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (message) {
      print(message);
      return;
    },onLaunch: (message) {
      print(message);
      return;
    }, onResume: (message) {
      print(message);
      return;
    },);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Future<void> intializeFunction() async {
    //   await Firebase.initializeApp();
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('LogOut'),
                    ],
                  ),
                ),
                value: 'LogOut',
              ),
            ],
            onChanged: (value) {
              if (value == 'LogOut') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).buttonColor,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Message(),
            ),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
