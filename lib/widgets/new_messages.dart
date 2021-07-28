import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _messagesController = new TextEditingController();
  String _newMessages = '';

  void _sendMessages() async {
    final userData = await FirebaseAuth.instance.currentUser();
    final userCollection = await Firestore.instance
        .collection('Users')
        .document(userData.uid)
        .get();
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('chats').add({
      'text': _newMessages,
      'time': Timestamp.now(),
      'userid': userData.uid,
      'user_name': userCollection['username'],
      'user_image': userCollection['image_url'],
    });
    _messagesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'Send a message....'),
              controller: _messagesController,
              onChanged: (value) {
                setState(() {
                  _newMessages = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _newMessages.trim().isEmpty ? null : _sendMessages,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
