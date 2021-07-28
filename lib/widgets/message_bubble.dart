import 'dart:ui';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String urlImage;
  final bool isMe;
  final Key key;

  MessageBubble(this.message, this.userName, this.urlImage, this.isMe,
      {this.key});

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: [
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                width: 140,
                decoration: BoxDecoration(
                  color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: isMe ? Radius.circular(12) : Radius.circular(12),
                    bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context).textTheme.headline1.color),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        message,
                        style: TextStyle(
                            color: isMe
                                ? Colors.black
                                : Theme.of(context).textTheme.headline1.color),
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -10,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(urlImage),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
