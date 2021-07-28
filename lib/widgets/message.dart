import 'package:chat_app/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapShots) {
        if (futureSnapShots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chats')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // Firebase.initializeApp();
            final documents = streamSnapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemBuilder: (ctx, i) => MessageBubble(
                documents[i]['text'],
                documents[i]['user_name'],
                documents[i]['user_image'],
                documents[i]['userid'] == futureSnapShots.data.uid,
                key: ValueKey(documents[i].documentID),
              ),
              itemCount: documents.length,
            );
          },
        );
      },
    );
  }
}
