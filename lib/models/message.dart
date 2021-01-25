

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message {

  String roomId; 
  String messageId; 
  final String messageText; 
  final String username; 

  Message({@required this.roomId, this.messageId, @required this.messageText, @required this.username}); 

  Map<String, dynamic> toMap() {
    return {
      "roomId": roomId, 
      "messageText": messageText, 
      "username": username
    };
  }

   factory Message.fromDocument(QueryDocumentSnapshot doc) {
    return Message(
      messageId: doc.id,
      roomId: doc["roomId"],
      messageText: doc["messageText"],
      username: doc["username"],
    );
  }

}