

import 'package:flutter/foundation.dart';
import 'package:lets_chat/models/message.dart';

class MessageViewModel {

  final Message message; 

  MessageViewModel({@required this.message});

  String get messageText {
    return message.messageText; 
  }

  

}
